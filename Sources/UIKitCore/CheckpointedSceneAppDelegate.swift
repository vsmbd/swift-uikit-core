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
open class CheckpointedSceneAppDelegate: CheckpointedAppDelegate,
										 @unchecked Sendable {
	/// The app's key window, if any.
	/// Uses the foreground active scene on iOS 13+
	open override var keyWindow: UIWindow? {
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
		let payload = Box((application, connectingSceneSession, options))
		return measured { [weak self, payload] in
			guard let self else {
				fatalError("Application delegate deallocated")
			}

			return app(
				payload.value.0,
				configurationForConnecting: payload.value.1,
				options: payload.value.2
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
		let payload = Box((application, sceneSessions))
		measured { [weak self, payload] in
			guard let self else { return }

			app(
				payload.value.0,
				didDiscardSceneSessions: payload.value.1
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
