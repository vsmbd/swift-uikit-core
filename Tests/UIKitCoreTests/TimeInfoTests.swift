//
//  TimeInfoTests.swift
//  UIKitCoreTests
//
//  Created by vsmbd on 04/02/26.
//

import Foundation
import Testing

@testable import UIKitCore
import SwiftCore

@Suite("TimeInfo")
struct TimeInfoTests {
	@Test
	func initStoresValues() {
		let wall = WallNanostamp(unixEpochNanoseconds: 1_000_000_000_000_000_000)
		let mono = MonotonicNanostamp(nanoseconds: 500_000_000_000)
		let info = TimeInfo(
			baselineWall: wall,
			baselineMonotonic: mono,
			timezoneOffsetSeconds: 19800
		)
		#expect(info.baselineWall == wall)
		#expect(info.baselineMonotonic == mono)
		#expect(info.baselineWall.unixEpochNanoseconds == 1_000_000_000_000_000_000)
		#expect(info.baselineMonotonic.nanoseconds == 500_000_000_000)
		#expect(info.timezoneOffsetSeconds == 19800)
	}

	@Test
	func equatableAndHashable() {
		let wall = WallNanostamp(unixEpochNanoseconds: 100)
		let mono = MonotonicNanostamp(nanoseconds: 200)
		let a = TimeInfo(baselineWall: wall, baselineMonotonic: mono, timezoneOffsetSeconds: 0)
		let b = TimeInfo(baselineWall: wall, baselineMonotonic: mono, timezoneOffsetSeconds: 0)
		let c = TimeInfo(baselineWall: wall, baselineMonotonic: mono, timezoneOffsetSeconds: 3600)

		#expect(a == b)
		#expect(a != c)

		var set: Set<TimeInfo> = []
		set.insert(a)
		set.insert(b)
		set.insert(c)
		#expect(set.count == 2)
	}

	@Test
	func codableRoundTrip() throws {
		let wall = WallNanostamp(unixEpochNanoseconds: 1_700_000_000_000_000_000)
		let mono = MonotonicNanostamp(nanoseconds: 1_000_000_000_000)
		let info = TimeInfo(
			baselineWall: wall,
			baselineMonotonic: mono,
			timezoneOffsetSeconds: -28800
		)
		let encoder = JSONEncoder()
		let decoder = JSONDecoder()

		let data = try encoder.encode(info)
		let decoded = try decoder.decode(TimeInfo.self, from: data)

		#expect(decoded.baselineWall == info.baselineWall)
		#expect(decoded.baselineMonotonic == info.baselineMonotonic)
		#expect(decoded.timezoneOffsetSeconds == info.timezoneOffsetSeconds)
	}
}
