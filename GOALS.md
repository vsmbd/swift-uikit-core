# GOALS

## 1) A predictable bootstrap for iOS 12+ apps
Provide a single, reusable base app delegate (`CheckpointedAppDelegate`) that establishes a consistent app lifecycle entry point across projects.

## 2) Define platform primitives that stay stable over time
Expose lightweight, reusable info types:
- AppInfo
- DeviceInfo
- TimeInfo

These types are intended to be:
- small
- dependency-free
- easy to serialize by downstream systems
- not tied to any specific telemetry backend

## 3) Deterministic session baselining
Capture a “session baseline” once at startup that downstream systems can depend on, especially for time conversions:
- wall clock for human readability
- monotonic clock for stable deltas
- timezone offset for context

## 4) Minimal dependencies, maximum portability
Keep UIKitCore buildable and usable in simple UIKit apps without forcing:
- backend credentials
- logging frameworks
- analytics SDKs
- database clients

## 5) A clean seam for higher-level observability tools
UIKitCore should make it easy for higher-level packages to attach behavior at app bootstrap without placing those concerns inside UIKitCore itself.
