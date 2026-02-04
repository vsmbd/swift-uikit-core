//
//  Utilities+Bundle.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import Foundation
import UIKit

// MARK: - Bundle + Info.plist helpers

public extension Bundle {
	/// Bundle identifier from Info.plist (e.g. `CFBundleIdentifier`). Empty string if missing.
	var safeBundleIdentifier: String {
		bundleIdentifier ?? "vsmbd.uikitcore"
	}

	/// Short version string from Info.plist (e.g. `CFBundleShortVersionString`). Empty string if missing.
	var appVersionString: String {
		(infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
	}
}

#endif
