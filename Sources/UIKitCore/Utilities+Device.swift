//
//  Utilities+Device.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import Foundation
import UIKit

// MARK: - Device / uname helpers

private let hardwareModel: String = {
	let unknown = "unknown"
	var name = utsname()

	guard uname(&name) == 0 else {
		return unknown
	}

	return withUnsafeBytes(of: &name.machine) { buffer -> String in
		guard let baseAddress = buffer.bindMemory(to: CChar.self)
			.baseAddress else {
			return unknown
		}

		return String(cString: baseAddress)
	}
}()

extension UIDevice {
	static func getDeviceInfo() -> DeviceInfo {
		let device = UIDevice.current

		return .init(
			osName: device.systemName,
			osVersion: device.systemVersion,
			hardwareModel: hardwareModel,
			manufacturer: "Apple"
		)
	}
}

#endif
