# UIKitCore (swift-uikit-core)

UIKitCore is a small, opinionated UIKit platform layer for iOS apps targeting **iOS 12+**.

Right now it provides one primary primitive:

- **CheckpointedAppDelegate**: a base `UIApplicationDelegate` that bootstraps a consistent app lifecycle and captures a deterministic “session baseline” (AppInfo, DeviceInfo, TimeInfo) at launch.

The goal is to make every app start from the same predictable foundation so higher-level packages (telemetry, diagnostics, performance tooling, feature modules) can plug in without each app inventing its own bootstrapping patterns.

---

## What you get

### CheckpointedAppDelegate
`CheckpointedAppDelegate` is intended to be subclassed by your app:

- centralizes bootstrap flow (launch, lifecycle transitions)
- captures a baseline snapshot exactly once per process/session
- provides a consistent place to attach “checkpoint” emissions later (future work)

UIKitCore does not require any networking, storage, or backend setup. It only captures and exposes baseline information.

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
  - a stable identifier for the install on that device (generated and persisted by the host app; UIKitCore does not prescribe storage)

Notes:
- UIKitCore will never infer business meaning from these values.
- UIKitCore will not attempt to generate or persist install identifiers by default (host app responsibility).

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
- `Sources/UIKitCore/AppInfo.swift`
- `Sources/UIKitCore/DeviceInfo.swift`
- `Sources/UIKitCore/TimeInfo.swift`

---

## Status
UIKitCore is intentionally small. Expect API surface to evolve as the railiOS ecosystem matures, but the intent is to keep this package stable and boring: bootstrapping + platform primitives.
