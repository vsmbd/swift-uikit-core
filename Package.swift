// swift-tools-version: 6.2

import PackageDescription

let package = Package(
	name: "UIKitCore",
	platforms: [
		.iOS(.v12)
	],
	products: [
		.library(
			name: "UIKitCore",
			targets: ["UIKitCore"]
		)
	],
	dependencies: [
		.package(
			url: "https://github.com/vsmbd/swift-core.git",
			branch: "main"
		),
		.package(
			url: "https://github.com/vsmbd/swift-eventdispatch.git",
			branch: "main"
		),
		.package(
			url: "https://github.com/vsmbd/swift-kvstore.git",
			branch: "main"
		),
		.package(
			url: "https://github.com/vsmbd/swift-telme.git",
			branch: "main"
		),
	],
	targets: [
		.target(
			name: "UIKitCore",
			dependencies: [
				.product(
					name: "SwiftCore",
					package: "swift-core"
				),
				.product(
					name: "EventDispatch",
					package: "swift-eventdispatch"
				),
				.product(
					name: "KVStore",
					package: "swift-kvstore"
				),
				.product(
					name: "Telme",
					package: "swift-telme"
				)
			],
			path: "Sources/UIKitCore"
		),
		.testTarget(
			name: "UIKitCoreTests",
			dependencies: [
				"UIKitCore",
				.product(
					name: "SwiftCore",
					package: "swift-core"
				),
			],
			path: "Tests/UIKitCoreTests"
		)
	]
)
