//
//  CheckpointedAppDelegate.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import CloudKit
import UIKit

// MARK: - CheckpointedAppDelegate

/// Base `UIApplicationDelegate` for consistent app lifecycle and session baselining.
/// Subclass to use as your app delegate; the empty callback implementations are not overridable.
open class CheckpointedAppDelegate: NSObject,
									UIApplicationDelegate {
	// MARK: + Public scope

	// MARK: ++ Init

	public override init() {
		super.init()
	}

	// MARK: ++ Launch

	public func application(
		_ application: UIApplication,
		willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		//
		return true
	}

	public func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		//
		return true
	}

	// MARK: ++ Lifecycle

	public func applicationDidBecomeActive(_ application: UIApplication) {
		//
	}

	public func applicationWillResignActive(_ application: UIApplication) {
		//
	}

	public func applicationDidEnterBackground(_ application: UIApplication) {
		//
	}

	public func applicationWillEnterForeground(_ application: UIApplication) {
		//
	}

	public func applicationWillTerminate(_ application: UIApplication) {
		//
	}

	// MARK: ++ Scenes (iOS 13+)

	@available(iOS 13.0, *)
	public func application(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		//
		return UISceneConfiguration(
			name: "Default Configuration",
			sessionRole: connectingSceneSession.role
		)
	}

	@available(iOS 13.0, *)
	public func application(
		_ application: UIApplication,
		didDiscardSceneSessions sceneSessions: Set<UISceneSession>
	) {
		//
	}

	// MARK: ++ Remote notifications

	public func application(
		_ application: UIApplication,
		didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
	) {
		//
	}

	public func application(
		_ application: UIApplication,
		didFailToRegisterForRemoteNotificationsWithError error: Error
	) {
		//
	}

	public func application(
		_ application: UIApplication,
		didReceiveRemoteNotification userInfo: [AnyHashable: Any],
		fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
	) {
		//
		completionHandler(.noData)
	}

	// MARK: ++ URL handling

	public func application(
		_ application: UIApplication,
		open url: URL,
		options: [UIApplication.OpenURLOptionsKey: Any] = [:]
	) -> Bool {
		//
		return false
	}

	@available(iOS, deprecated: 9.0, message: "Use application(_:open:options:) instead")
	public func application(
		_ application: UIApplication,
		handleOpen url: URL
	) -> Bool {
		//
		return false
	}

	// MARK: ++ Background URL session

	public func application(
		_ application: UIApplication,
		handleEventsForBackgroundURLSession identifier: String,
		completionHandler: @escaping () -> Void
	) {
		//
		completionHandler()
	}

	// MARK: ++ Shortcuts

	public func application(
		_ application: UIApplication,
		performActionFor shortcutItem: UIApplicationShortcutItem,
		completionHandler: @escaping (Bool) -> Void
	) {
		//
		completionHandler(false)
	}

	// MARK: ++ Protected data

	public func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
		//
	}

	public func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
		//
	}

	// MARK: ++ Interface orientation

	public func application(
		_ application: UIApplication,
		supportedInterfaceOrientationsFor window: UIWindow?
	) -> UIInterfaceOrientationMask {
		//
		return .all
	}

	// MARK: ++ Extension point

	public func application(
		_ application: UIApplication,
		shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier
	) -> Bool {
		//
		return true
	}

	// MARK: ++ State restoration

	public func application(
		_ application: UIApplication,
		viewControllerWithRestorationIdentifierPath identifierComponents: [String],
		coder: NSCoder
	) -> UIViewController? {
		//
		return nil
	}

	public func application(
		_ application: UIApplication,
		shouldSaveApplicationState coder: NSCoder
	) -> Bool {
		//
		return false
	}

	public func application(
		_ application: UIApplication,
		shouldRestoreApplicationState coder: NSCoder
	) -> Bool {
		//
		return false
	}

	// MARK: ++ User activity

	public func application(
		_ application: UIApplication,
		willContinueUserActivityWithType userActivityType: String
	) -> Bool {
		//
		return false
	}

	public func application(
		_ application: UIApplication,
		continue userActivity: NSUserActivity,
		restorationHandler: @escaping ([any UIUserActivityRestoring]?) -> Void
	) -> Bool {
		//
		return false
	}

	public func application(
		_ application: UIApplication,
		didUpdate userActivity: NSUserActivity
	) {
		//
	}

	public func application(
		_ application: UIApplication,
		didFailToContinueUserActivityWithType userActivityType: String,
		error: Error
	) {
		//
	}

	// MARK: ++ CloudKit share (iOS 10+)

	public func application(
		_ application: UIApplication,
		userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata
	) {
		//
	}
}

#endif
