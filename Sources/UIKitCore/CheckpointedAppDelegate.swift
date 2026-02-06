//
//  CheckpointedAppDelegate.swift
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

// MARK: - CheckpointedAppDelegate

/// Base `UIApplicationDelegate` for consistent app lifecycle and session baselining.
/// Subclass to use as your app delegate; the empty callback implementations are not overridable.
open class CheckpointedAppDelegate: UIResponder,
									UIApplicationDelegate,
									Entity {
	// MARK: + Private scope

	private enum Key {
		static let installId = "installId"
	}

	private static func getTimeInfo(baseline: TimeBaseline) -> TimeInfo {
		.init(
			baselineWall: baseline.wall,
			baselineMonotonic: baseline.monotonic,
			timezoneOffsetSeconds: TimeZone.current.offsetSecondsFromUTC
		)
	}

	private static func resolveInstallId(_ secureStore: KVStore) -> UUID {
		func insertNewID() -> UUID {
			let newId = UUID()
			_ = secureStore.setString(
				Key.installId,
				value: newId.uuidString
			)
			return newId
		}

		let result = secureStore.getString(Key.installId)

		switch result {
		case .success(let stored, _):
			if let stored,
			   let uuid = UUID(uuidString: stored) {
				return uuid
			}

			return insertNewID()

		case .failure:
			return insertNewID()
		}
	}

	private static func getAppInfo(installId: UUID) -> AppInfo {
		let bundle = Bundle.main

		return .init(
			bundleId: bundle.safeBundleIdentifier,
			appVersion: bundle.appVersionString,
			installId: installId
		)
	}

	// MARK: + Public scope

	public let identifier: UInt64

	/// UserDefaults-backed store for non-sensitive settings. Exposed as `KVStore` only.
	public let settingsStore: KVStore

	/// Keychain-backed store for sensitive values. Exposed as `KVStore` only.
	public let secureStore: KVStore

	public let sessionId: UUID = .init()
	public let timeInfo: TimeInfo
	public let appInfo: AppInfo
	public let deviceInfo: DeviceInfo

	open var window: UIWindow?

	// MARK: ++ Init

	public override init() {
		let baseline = timeBaseline
		self.identifier = Self.nextID

		self.timeInfo = Self.getTimeInfo(baseline: baseline)

		self.settingsStore = SettingsStore()

		let bundle = Bundle.main
		let secureStore = SecureStore(service: bundle.safeBundleIdentifier)
		self.secureStore = secureStore

		let resolvedInstallId = Self.resolveInstallId(secureStore)
		self.appInfo = Self.getAppInfo(installId: resolvedInstallId)

		self.deviceInfo = UIDevice.getDeviceInfo()

		super.init()

		Telme.default.setup(.checkpoint(self))

		measured {
			initialize()
		}
	}

	open func initialize() {
		//
	}

	// MARK: ++ Launch

	public func application(
		_ application: UIApplication,
		willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		measured {
			app(
				application,
				willFinishLaunchingWithOptions: launchOptions
			)
		}
	}

	open func app(
		_ application: UIApplication,
		willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		return true
	}

	public func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		measured {
			app(
				application,
				didFinishLaunchingWithOptions: launchOptions
			)
		}
	}

	open func app(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		return true
	}

	// MARK: ++ Lifecycle

	public func applicationDidBecomeActive(_ application: UIApplication) {
		measured {
			appDidBecomeActive(application)
		}
	}

	open func appDidBecomeActive(_ application: UIApplication) {
		//
	}

	public func applicationWillResignActive(_ application: UIApplication) {
		measured {
			appWillResignActive(application)
		}
	}

	open func appWillResignActive(_ application: UIApplication) {
		//
	}

	public func applicationDidEnterBackground(_ application: UIApplication) {
		measured {
			appDidEnterBackground(application)
		}
	}

	open func appDidEnterBackground(_ application: UIApplication) {
		//
	}

	public func applicationWillEnterForeground(_ application: UIApplication) {
		measured {
			appWillEnterForeground(application)
		}
	}

	open func appWillEnterForeground(_ application: UIApplication) {
		//
	}

	public func applicationWillTerminate(_ application: UIApplication) {
		measured {
			appWillTerminate(application)
		}
	}

	open func appWillTerminate(_ application: UIApplication) {
		//
	}

	// MARK: ++ Remote notifications

	public func application(
		_ application: UIApplication,
		didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
	) {
		measured {
			app(
				application,
				didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
			)
		}
	}

	open func app(
		_ application: UIApplication,
		didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
	) {
		//
	}

	public func application(
		_ application: UIApplication,
		didFailToRegisterForRemoteNotificationsWithError error: Error
	) {
		measured {
			app(
				application,
				didFailToRegisterForRemoteNotificationsWithError: error
			)
		}
	}

	open func app(
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
		measured {
			app(
				application,
				didReceiveRemoteNotification: userInfo,
				fetchCompletionHandler: completionHandler
			)
		}
	}

	open func app(
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
		measured {
			app(
				application,
				open: url,
				options: options
			)
		}
	}

	open func app(
		_ application: UIApplication,
		open url: URL,
		options: [UIApplication.OpenURLOptionsKey: Any] = [:]
	) -> Bool {
		return false
	}

	// MARK: ++ Background URL session

	public func application(
		_ application: UIApplication,
		handleEventsForBackgroundURLSession identifier: String,
		completionHandler: @escaping () -> Void
	) {
		measured {
			app(
				application,
				handleEventsForBackgroundURLSession: identifier,
				completionHandler: completionHandler
			)
		}
	}

	open func app(
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
		measured {
			app(
				application,
				performActionFor: shortcutItem,
				completionHandler: completionHandler
			)
		}
	}

	open func app(
		_ application: UIApplication,
		performActionFor shortcutItem: UIApplicationShortcutItem,
		completionHandler: @escaping (Bool) -> Void
	) {
		//
		completionHandler(false)
	}

	// MARK: ++ Protected data

	public func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
		measured {
			appProtectedDataDidBecomeAvailable(application)
		}
	}

	open func appProtectedDataDidBecomeAvailable(_ application: UIApplication) {
		//
	}

	public func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
		measured {
			appProtectedDataWillBecomeUnavailable(application)
		}
	}

	open func appProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
		//
	}

	// MARK: ++ Interface orientation

	public func application(
		_ application: UIApplication,
		supportedInterfaceOrientationsFor window: UIWindow?
	) -> UIInterfaceOrientationMask {
		measured {
			app(
				application,
				supportedInterfaceOrientationsFor: window
			)
		}
	}

	open func app(
		_ application: UIApplication,
		supportedInterfaceOrientationsFor window: UIWindow?
	) -> UIInterfaceOrientationMask {
		return .all
	}

	// MARK: ++ Extension point

	public func application(
		_ application: UIApplication,
		shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier
	) -> Bool {
		measured {
			app(
				application,
				shouldAllowExtensionPointIdentifier: extensionPointIdentifier
			)
		}
	}

	open func app(
		_ application: UIApplication,
		shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier
	) -> Bool {
		return true
	}

	// MARK: ++ State restoration

	public func application(
		_ application: UIApplication,
		viewControllerWithRestorationIdentifierPath identifierComponents: [String],
		coder: NSCoder
	) -> UIViewController? {
		measured {
			app(
				application,
				viewControllerWithRestorationIdentifierPath: identifierComponents,
				coder: coder
			)
		}
	}

	open func app(
		_ application: UIApplication,
		viewControllerWithRestorationIdentifierPath identifierComponents: [String],
		coder: NSCoder
	) -> UIViewController? {
		return nil
	}

	public func application(
		_ application: UIApplication,
		shouldSaveSecureApplicationState coder: NSCoder
	) -> Bool {
		measured {
			app(
				application,
				shouldSaveSecureApplicationState: coder
			)
		}
	}

	open func app(
		_ application: UIApplication,
		shouldSaveSecureApplicationState coder: NSCoder
	) -> Bool {
		return false
	}

	public func application(
		_ application: UIApplication,
		shouldRestoreApplicationState coder: NSCoder
	) -> Bool {
		measured {
			app(
				application,
				shouldRestoreApplicationState: coder
			)
		}
	}

	open func app(
		_ application: UIApplication,
		shouldRestoreApplicationState coder: NSCoder
	) -> Bool {
		return false
	}

	// MARK: ++ User activity

	public func application(
		_ application: UIApplication,
		willContinueUserActivityWithType userActivityType: String
	) -> Bool {
		measured {
			app(
				application,
				willContinueUserActivityWithType: userActivityType
			)
		}
	}

	open func app(
		_ application: UIApplication,
		willContinueUserActivityWithType userActivityType: String
	) -> Bool {
		return false
	}

	public func application(
		_ application: UIApplication,
		continue userActivity: NSUserActivity,
		restorationHandler: @escaping ([any UIUserActivityRestoring]?) -> Void
	) -> Bool {
		measured {
			app(
				application,
				continue: userActivity,
				restorationHandler: restorationHandler
			)
		}
	}

	open func app(
		_ application: UIApplication,
		continue userActivity: NSUserActivity,
		restorationHandler: @escaping ([any UIUserActivityRestoring]?) -> Void
	) -> Bool {
		return false
	}

	public func application(
		_ application: UIApplication,
		didUpdate userActivity: NSUserActivity
	) {
		measured {
			app(
				application,
				didUpdate: userActivity
			)
		}
	}

	open func app(
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
		measured {
			app(
				application,
				didFailToContinueUserActivityWithType: userActivityType,
				error: error
			)
		}
	}

	open func app(
		_ application: UIApplication,
		didFailToContinueUserActivityWithType userActivityType: String,
		error: Error
	) {
		//
	}

	// MARK: ++ CloudKit share

	public func application(
		_ application: UIApplication,
		userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata
	) {
		measured {
			app(
				application,
				userDidAcceptCloudKitShareWith: cloudKitShareMetadata
			)
		}
	}

	open func app(
		_ application: UIApplication,
		userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata
	) {
		//
	}
}

#endif
