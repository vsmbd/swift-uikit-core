# UIKitCore (swift-uikit-core)

UIKitCore is a small, opinionated UIKit platform layer for iOS apps targeting **iOS 12+**.

It provides checkpointed lifecycle bases so every app and scene can use the same predictable foundation:

- **CheckpointedAppDelegate**: base `UIApplicationDelegate` that bootstraps app lifecycle and captures a deterministic “session baseline” (AppInfo, DeviceInfo, TimeInfo) at launch.
- **CheckpointedSceneDelegate**: base `UISceneDelegate` for iOS 13+ scene lifecycle (connection, foreground/background, URL contexts, user activity, state restoration).
- **CheckpointedView**: base `UIView` with checkpointed layout, drawing, hit-test, and superview/window lifecycle hooks.
- **CheckpointedViewController**: base `UIViewController` with checkpointed load/view lifecycle, layout, transition, and parent/trait hooks.

Each type follows the same pattern: system callbacks are wrapped in `measured { }` and forwarded to open methods with a short prefix (`app`, `scn`, `vw`, `vc`). Subclass and override those open methods to customize behavior; the protocol-fulfilling methods are not intended to be overridden so checkpointing stays consistent.

The goal is to make app, scene, view, and view-controller lifecycles observable and consistent so higher-level packages (telemetry, diagnostics, performance tooling, feature modules) can plug in without each app inventing its own patterns.

---

## What you get

### CheckpointedAppDelegate
Subclass as your app delegate:

- centralizes bootstrap flow (launch, lifecycle, scenes, URLs, user activity, state restoration, etc.)
- captures a baseline snapshot exactly once per process/session (AppInfo, DeviceInfo, TimeInfo)
- exposes `settingsStore` (UserDefaults) and `secureStore` (Keychain) for install/session identity
- provides `keyWindow` (foreground scene on iOS 13+)
- registers with Telme for app-level checkpointing

Override the open `app...` methods; do not override the `application(...)` methods.

### CheckpointedSceneDelegate (iOS 13+)
Subclass as your scene delegate when using scene-based lifecycle:

- handles scene connection, disconnect, and lifecycle (active, foreground, background)
- URL contexts, user activity (continue, fail, update), and state restoration
- override the open `scn...` methods; do not override the `scene(...)` / `sceneDid...` methods

### CheckpointedView
Subclass for views that participate in checkpointing:

- layout (`layoutSubviews`, `updateConstraints`), drawing (`draw`), sizing (`sizeThatFits`)
- superview/window moves, hit-test (`point(inside:with:)`, `hitTest(_:with:)`), traits
- override the open `vw...` methods; do not override the UIKit overrides

Programmatic init only: use `init(frame:)`; `init(coder:)` fatals.

### CheckpointedViewController
Subclass for view controllers that participate in checkpointing:

- view load, viewDidLoad, will/did appear/disappear, layout, transition, parent move, traits
- `viewIsAppearing` (iOS 13+)
- override the open `vc...` methods; do not override the UIKit overrides

Programmatic init only: use `init()`; nib/coder inits fatal.

UIKitCore does not require any networking, storage, or backend setup beyond what CheckpointedAppDelegate uses for install/session identity. It captures and exposes baseline information and provides consistent lifecycle hooks.

---

## Core types

UIKitCore exposes three foundational info types. These are meant to be stable, low-level, and broadly reusable (not tied to any specific telemetry product).

### AppInfo
App identity and versioning.

Recommended fields:
- `bundleId: String`
  - e.g. `com.yourorg.yourapp`
- `appVersion: String`
  - human-facing version string (e.g. `1.4.2`)
- `installId: UUID`
  - a stable identifier for the install on that device (generated and persisted by `CheckpointedAppDelegate` via its `secureStore`)

Notes:
- UIKitCore will never infer business meaning from these values.

---

### DeviceInfo
Device + OS identity.

Recommended fields:
- `osName: String`
  - e.g. `iOS`
- `osVersion: String`
  - e.g. `15.5`
- `hardwareModel: String`
  - e.g. `iPhone13,2`
- `manufacturer: String`
  - usually `Apple`

Notes:
- This is intended for debugging, diagnostics, and slicing data by environment.
- Keep this lightweight. No attempt is made to normalize model names (that’s a higher-level concern).

---

### TimeInfo
A session baseline for converting monotonic timestamps into wall-clock time without relying on wall-clock stability.

Recommended fields:
- `baselineWallNanos: UInt64`
  - epoch-based wall time captured at baseline
- `baselineMonoNanos: UInt64`
  - monotonic time captured at the same instant as `baselineWallNanos`
- `timezoneOffsetSeconds: Int32`
  - seconds offset from UTC at baseline (e.g. `19800` for IST)

Why both wall + monotonic baselines?
- Wall clocks can jump (NTP adjustments, user changes).
- Monotonic clocks are stable for deltas.
- With both captured at the same moment, you can reconstruct event wall time from monotonic time:

`eventWallNanos = baselineWallNanos + (eventMonoNanos - baselineMonoNanos)`

Notes:
- Ordering should remain based on deterministic sequence numbers (if used) or monotonic time. Wall clock is primarily for display and range filters.

---

## Requirements
- iOS 12+
- Swift Package Manager

---

## Repository structure (suggested)
- `Sources/UIKitCore/CheckpointedAppDelegate.swift`
- `Sources/UIKitCore/CheckpointedSceneDelegate.swift`
- `Sources/UIKitCore/CheckpointedView.swift`
- `Sources/UIKitCore/CheckpointedViewController.swift`
- `Sources/UIKitCore/AppInfo.swift`
- `Sources/UIKitCore/DeviceInfo.swift`
- `Sources/UIKitCore/TimeInfo.swift`
- `Sources/UIKitCore/Utilities+*.swift`
- `Sources/UIKitCore/UIView+*.swift` (layout, anchor, chain, etc.)

---

## Status
UIKitCore is intentionally small. Expect API surface to evolve as the ecosystem matures, but the intent is to keep this package stable and boring: bootstrapping + checkpointed lifecycle bases + platform primitives.
