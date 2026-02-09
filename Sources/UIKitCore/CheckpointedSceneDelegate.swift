//
//  CheckpointedSceneDelegate.swift
//  UIKitCore
//
//  Created by vsmbd on 09/02/26.
//

#if os(iOS) || os(tvOS)

import SwiftCore
import Telme
import UIKit

// MARK: - CheckpointedSceneDelegate

/// Base `UISceneDelegate` for consistent scene lifecycle and checkpointing (iOS 13+).
/// Subclass and override the open `scn...` methods to customize behavior.
@available(iOS 13.0, tvOS 13.0, *)
open class CheckpointedSceneDelegate: UIResponder,
									  UISceneDelegate,
									  Entity {
	// MARK: + Public scope

	public let identifier: UInt64

	/// The window for this scene. Set in `scnWillConnect` (or from the scene's windows).
	open var window: UIWindow?

	// MARK: ++ Init

	public override init() {
		self.identifier = Self.nextID

		super.init()

		measured {
			initialize()
		}
	}

	open func initialize() {
		//
	}

	// MARK: ++ Connection

	public func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		measured {
			scn(
				scene,
				willConnectTo: session,
				options: connectionOptions
			)
		}
	}

	open func scn(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		//
	}

	public func sceneDidDisconnect(_ scene: UIScene) {
		measured {
			scnDidDisconnect(scene)
		}
	}

	open func scnDidDisconnect(_ scene: UIScene) {
		//
	}

	// MARK: ++ Lifecycle

	public func sceneDidBecomeActive(_ scene: UIScene) {
		measured {
			scnDidBecomeActive(scene)
		}
	}

	open func scnDidBecomeActive(_ scene: UIScene) {
		//
	}

	public func sceneWillResignActive(_ scene: UIScene) {
		measured {
			scnWillResignActive(scene)
		}
	}

	open func scnWillResignActive(_ scene: UIScene) {
		//
	}

	public func sceneWillEnterForeground(_ scene: UIScene) {
		measured {
			scnWillEnterForeground(scene)
		}
	}

	open func scnWillEnterForeground(_ scene: UIScene) {
		//
	}

	public func sceneDidEnterBackground(_ scene: UIScene) {
		measured {
			scnDidEnterBackground(scene)
		}
	}

	open func scnDidEnterBackground(_ scene: UIScene) {
		//
	}

	// MARK: ++ URL contexts

	public func scene(
		_ scene: UIScene,
		openURLContexts URLContexts: Set<UIOpenURLContext>
	) {
		measured {
			scn(
				scene,
				openURLContexts: URLContexts
			)
		}
	}

	open func scn(
		_ scene: UIScene,
		openURLContexts URLContexts: Set<UIOpenURLContext>
	) {
		//
	}

	// MARK: ++ User activity

	public func scene(
		_ scene: UIScene,
		willContinueUserActivityWithType userActivityType: String
	) {
		measured {
			scn(
				scene,
				willContinueUserActivityWithType: userActivityType
			)
		}
	}

	open func scn(
		_ scene: UIScene,
		willContinueUserActivityWithType userActivityType: String
	) {
		//
	}

	public func scene(
		_ scene: UIScene,
		continue userActivity: NSUserActivity,
		restorationHandler: @escaping ([any UIUserActivityRestoring]?) -> Void
	) {
		measured {
			scn(
				scene,
				continue: userActivity,
				restorationHandler: restorationHandler
			)
		}
	}

	open func scn(
		_ scene: UIScene,
		continue userActivity: NSUserActivity,
		restorationHandler: @escaping ([any UIUserActivityRestoring]?) -> Void
	) {
		restorationHandler(nil)
	}

	public func scene(
		_ scene: UIScene,
		didFailToContinueUserActivityWithType userActivityType: String,
		error: Error
	) {
		measured {
			scn(
				scene,
				didFailToContinueUserActivityWithType: userActivityType,
				error: error
			)
		}
	}

	open func scn(
		_ scene: UIScene,
		didFailToContinueUserActivityWithType userActivityType: String,
		error: Error
	) {
		//
	}

	public func scene(
		_ scene: UIScene,
		didUpdate userActivity: NSUserActivity
	) {
		measured {
			scn(
				scene,
				didUpdate: userActivity
			)
		}
	}

	open func scn(
		_ scene: UIScene,
		didUpdate userActivity: NSUserActivity
	) {
		//
	}

	// MARK: ++ State restoration

	public func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
		measured {
			scnStateRestorationActivity(for: scene)
		}
	}

	open func scnStateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
		nil
	}
}

#endif
