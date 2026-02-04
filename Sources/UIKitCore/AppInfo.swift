//
//  AppInfo.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

import Foundation

// MARK: - AppInfo

/// App identity and versioning for session baselines and diagnostics.
@frozen
public struct AppInfo: Codable,
					   Sendable,
					   Equatable,
					   Hashable {
	// MARK: + Public scope

	public let bundleId: String
	public let appVersion: String
	public let installId: UUID

	public init(
		bundleId: String,
		appVersion: String,
		installId: UUID
	) {
		self.bundleId = bundleId
		self.appVersion = appVersion
		self.installId = installId
	}
}
