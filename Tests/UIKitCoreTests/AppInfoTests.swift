//
//  AppInfoTests.swift
//  UIKitCoreTests
//
//  Created by vsmbd on 04/02/26.
//

import Foundation
import Testing

@testable import UIKitCore

@Suite("AppInfo")
struct AppInfoTests {
	@Test
	func initStoresValues() {
		let id = UUID()
		let info = AppInfo(
			bundleId: "com.example.app",
			appVersion: "1.2.3",
			installId: id
		)
		#expect(info.bundleId == "com.example.app")
		#expect(info.appVersion == "1.2.3")
		#expect(info.installId == id)
	}

	@Test
	func equatableAndHashable() {
		let id = UUID()
		let a = AppInfo(bundleId: "a", appVersion: "1", installId: id)
		let b = AppInfo(bundleId: "a", appVersion: "1", installId: id)
		let c = AppInfo(bundleId: "b", appVersion: "1", installId: id)

		#expect(a == b)
		#expect(a != c)

		var set: Set<AppInfo> = []
		set.insert(a)
		set.insert(b)
		set.insert(c)
		#expect(set.count == 2)
	}

	@Test
	func codableRoundTrip() throws {
		let id = UUID()
		let info = AppInfo(
			bundleId: "com.test.app",
			appVersion: "2.0.0",
			installId: id
		)
		let encoder = JSONEncoder()
		let decoder = JSONDecoder()

		let data = try encoder.encode(info)
		let decoded = try decoder.decode(AppInfo.self, from: data)

		#expect(decoded.bundleId == info.bundleId)
		#expect(decoded.appVersion == info.appVersion)
		#expect(decoded.installId == info.installId)
	}
}
