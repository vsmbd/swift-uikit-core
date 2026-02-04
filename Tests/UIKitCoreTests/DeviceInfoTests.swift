//
//  DeviceInfoTests.swift
//  UIKitCoreTests
//
//  Created by vsmbd on 04/02/26.
//

import Foundation
import Testing

@testable import UIKitCore

@Suite("DeviceInfo")
struct DeviceInfoTests {
	@Test
	func initStoresValues() {
		let info = DeviceInfo(
			osName: "iOS",
			osVersion: "17.0",
			hardwareModel: "iPhone15,2",
			manufacturer: "Apple"
		)
		#expect(info.osName == "iOS")
		#expect(info.osVersion == "17.0")
		#expect(info.hardwareModel == "iPhone15,2")
		#expect(info.manufacturer == "Apple")
	}

	@Test
	func equatableAndHashable() {
		let a = DeviceInfo(osName: "iOS", osVersion: "17", hardwareModel: "iPhone", manufacturer: "Apple")
		let b = DeviceInfo(osName: "iOS", osVersion: "17", hardwareModel: "iPhone", manufacturer: "Apple")
		let c = DeviceInfo(osName: "iOS", osVersion: "18", hardwareModel: "iPhone", manufacturer: "Apple")

		#expect(a == b)
		#expect(a != c)

		var set: Set<DeviceInfo> = []
		set.insert(a)
		set.insert(b)
		set.insert(c)
		#expect(set.count == 2)
	}

	@Test
	func codableRoundTrip() throws {
		let info = DeviceInfo(
			osName: "iOS",
			osVersion: "15.5",
			hardwareModel: "iPhone13,2",
			manufacturer: "Apple"
		)
		let encoder = JSONEncoder()
		let decoder = JSONDecoder()

		let data = try encoder.encode(info)
		let decoded = try decoder.decode(DeviceInfo.self, from: data)

		#expect(decoded.osName == info.osName)
		#expect(decoded.osVersion == info.osVersion)
		#expect(decoded.hardwareModel == info.hardwareModel)
		#expect(decoded.manufacturer == info.manufacturer)
	}
}
