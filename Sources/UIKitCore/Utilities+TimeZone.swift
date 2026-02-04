//
//  Utilities+TimeZone.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import Foundation
import UIKit

// MARK: - TimeZone

public extension TimeZone {
	/// Seconds offset from UTC at the current moment. Suitable for `TimeInfo.timezoneOffsetSeconds`.
	var offsetSecondsFromUTC: Int32 {
		Int32(truncatingIfNeeded: secondsFromGMT())
	}
}

#endif
