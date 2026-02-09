# GOALS

## 1) A predictable bootstrap for iOS 12+ apps
Provide a single, reusable base app delegate (`CheckpointedAppDelegate`) that establishes a consistent app lifecycle entry point across projects.

## 2) Consistent scene lifecycle (iOS 13+)
Provide a base scene delegate (`CheckpointedSceneDelegate`) that mirrors the app-delegate pattern for scene-based lifecycle: connection, foreground/background, URL contexts, user activity, and state restoration. Subclasses override open `scn...` methods; checkpointing wraps all `UISceneDelegate` callbacks.

## 3) Consistent view and view-controller lifecycle
Provide base types (`CheckpointedView`, `CheckpointedViewController`) so view and view-controller lifecycles (load, appear, layout, traits, etc.) follow the same “measured → open hook” pattern. Subclasses override open `vw...` / `vc...` methods; checkpointing wraps the relevant UIKit overrides.

## 4) Define platform primitives that stay stable over time
Expose lightweight, reusable info types:
- AppInfo
- DeviceInfo
- TimeInfo

These types are intended to be:
- small
- dependency-free
- easy to serialize by downstream systems
- not tied to any specific telemetry backend

## 5) Deterministic session baselining
Capture a “session baseline” once at startup that downstream systems can depend on, especially for time conversions:
- wall clock for human readability
- monotonic clock for stable deltas
- timezone offset for context

## 6) Minimal dependencies, maximum portability
Keep UIKitCore buildable and usable in simple UIKit apps without forcing:
- backend credentials
- logging frameworks
- analytics SDKs
- database clients

## 7) A clean seam for higher-level observability tools
UIKitCore should make it easy for higher-level packages to attach behavior at app and scene bootstrap (and, via the checkpointed view/view-controller bases, at view lifecycle) without placing those concerns inside UIKitCore itself.
