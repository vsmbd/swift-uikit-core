//
//  CheckpointedSceneAppDelegate.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import CloudKit
import KVStore
import SwiftCore
import UIKit
import Telme

// MARK: - CheckpointedSceneAppDelegate

@available(iOS 13.0, *)
open class CheckpointedSceneAppDelegate: CheckpointedAppDelegate {
	/// The app's key window, if any.
	/// Uses the foreground active scene on iOS 13+
	open var keyWindow: UIWindow? {
		let scenes = UIApplication.shared
			.connectedScenes
			.compactMap { $0 as? UIWindowScene }

		if #available(iOS 15.0, *) {
			return scenes
				.first { $0.activationState == .foregroundActive }?
				.keyWindow
			?? scenes.first?.keyWindow
		} else {
			return scenes.flatMap(\.windows)
				.first(where: \.isKeyWindow)
		}
	}

	// MARK: ++ Scenes

	public func application(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		measured {
			app(
				application,
				configurationForConnecting: connectingSceneSession,
				options: options
			)
		}
	}

	open func app(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		fatalError("Must be overriden by subclasses")
	}

	public func application(
		_ application: UIApplication,
		didDiscardSceneSessions sceneSessions: Set<UISceneSession>
	) {
		measured {
			app(
				application,
				didDiscardSceneSessions: sceneSessions
			)
		}
	}

	open func app(
		_ application: UIApplication,
		didDiscardSceneSessions sceneSessions: Set<UISceneSession>
	) {
		//
	}
}

#endif
