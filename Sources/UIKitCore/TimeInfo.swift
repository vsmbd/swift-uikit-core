//
//  TimeInfo.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

import Foundation
import SwiftCore

// MARK: - TimeInfo

/// Session baseline for converting monotonic timestamps to wall-clock time without relying on wall-clock stability.
///
/// Wall and monotonic baselines are captured at the same instant. Reconstruct event wall time with:
/// `eventWall = baselineWall.unixEpochNanoseconds + (eventMono.nanoseconds - baselineMonotonic.nanoseconds)` (as nanos).
///
/// Ordering should remain based on monotonic time or sequence numbers; wall clock is for display and range filters.
@frozen
public struct TimeInfo: Codable,
						Sendable,
						Equatable,
						Hashable {
	// MARK: + Public scope

	/// Wall-clock time (Unix epoch UTC) captured at baseline.
	public let baselineWall: WallNanostamp
	/// Monotonic time captured at the same instant as `baselineWall`.
	public let baselineMonotonic: MonotonicNanostamp
	/// Seconds offset from UTC at baseline (e.g. 19800 for IST).
	public let timezoneOffsetSeconds: Int32

	public init(
		baselineWall: WallNanostamp,
		baselineMonotonic: MonotonicNanostamp,
		timezoneOffsetSeconds: Int32
	) {
		self.baselineWall = baselineWall
		self.baselineMonotonic = baselineMonotonic
		self.timezoneOffsetSeconds = timezoneOffsetSeconds
	}
}
