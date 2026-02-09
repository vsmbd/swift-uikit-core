# NONGOALS

## 1) Not a telemetry/observability product
UIKitCore does not define:
- event schemas
- log/trace/metric models
- ingestion protocols
- batching/retry policies
- backend adapters (ClickHouse, OTEL, etc.)

Those belong in separate packages.

## 2) Not a networking layer
UIKitCore will not:
- send data over the network
- manage HTTPS tunnels
- implement auth/token refresh
- own endpoints or transport formats

## 3) Not a persistence layer
UIKitCore will not:
- create or manage local databases
- manage retention policies
- own file layouts
- define migration tooling

If an install identifier or other value must be persisted, that is the host app’s responsibility (or a higher-level package).

## 4) Not an app architecture framework
UIKitCore will not impose:
- coordinator patterns
- DI containers
- routing frameworks
- state management approaches
- MVVM/MVI opinionation

It provides checkpointed lifecycle bases (AppDelegate, SceneDelegate, View, ViewController) and a bootstrap seam, not a complete architecture or a full UI component/layout framework.

## 5) Not a compatibility abstraction for every iOS version quirk
UIKitCore targets iOS 12+ and aims for pragmatic compatibility, but it will not become a grab bag of unrelated polyfills. Anything that isn’t directly related to bootstrapping and platform primitives should live elsewhere.
