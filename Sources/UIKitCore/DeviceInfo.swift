//
//  DeviceInfo.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

import Foundation

// MARK: - DeviceInfo

/// Device and OS identity for session baselines, debugging, and slicing data by environment.
///
/// Intended to stay lightweight.
@frozen
public struct DeviceInfo: Codable,
						  Sendable,
						  Equatable,
						  Hashable {
	// MARK: + Public scope

	public let osName: String
	public let osVersion: String
	public let hardwareModel: String
	public let manufacturer: String

	public init(
		osName: String,
		osVersion: String,
		hardwareModel: String,
		manufacturer: String
	) {
		self.osName = osName
		self.osVersion = osVersion
		self.hardwareModel = hardwareModel
		self.manufacturer = manufacturer
	}
}
