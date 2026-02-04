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
									Entity,
									@unchecked Sendable {
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

		measured { [weak self] in
			guard let self else { return }

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
		let payload = Box((application, launchOptions))
		return measured { [weak self, payload] in
			guard let self else { return true }

			return app(
				payload.value.0,
				willFinishLaunchingWithOptions: payload.value.1
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
		let payload = Box((application, launchOptions))
		return measured { [weak self, payload] in
			guard let self else { return true }

			return app(
				payload.value.0,
				didFinishLaunchingWithOptions: payload.value.1
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
		let applicationBox = Box(application)
		measured { [weak self, applicationBox] in
			guard let self else { return }

			appDidBecomeActive(applicationBox.value)
		}
	}

	open func appDidBecomeActive(_ application: UIApplication) {
		//
	}

	public func applicationWillResignActive(_ application: UIApplication) {
		let applicationBox = Box(application)
		measured { [weak self, applicationBox] in
			guard let self else { return }

			appWillResignActive(applicationBox.value)
		}
	}

	open func appWillResignActive(_ application: UIApplication) {
		//
	}

	public func applicationDidEnterBackground(_ application: UIApplication) {
		let applicationBox = Box(application)
		measured { [weak self, applicationBox] in
			guard let self else { return }

			appDidEnterBackground(applicationBox.value)
		}
	}

	open func appDidEnterBackground(_ application: UIApplication) {
		//
	}

	public func applicationWillEnterForeground(_ application: UIApplication) {
		let applicationBox = Box(application)
		measured { [weak self, applicationBox] in
			guard let self else { return }

			appWillEnterForeground(applicationBox.value)
		}
	}

	open func appWillEnterForeground(_ application: UIApplication) {
		//
	}

	public func applicationWillTerminate(_ application: UIApplication) {
		let applicationBox = Box(application)
		measured { [weak self, applicationBox] in
			guard let self else { return }

			appWillTerminate(applicationBox.value)
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
		let payload = Box((application, deviceToken))
		measured { [weak self, payload] in
			guard let self else { return }

			app(
				payload.value.0,
				didRegisterForRemoteNotificationsWithDeviceToken: payload.value.1
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
		let payload = Box((application, error))
		measured { [weak self, payload] in
			guard let self else { return }

			app(
				payload.value.0,
				didFailToRegisterForRemoteNotificationsWithError: payload.value.1
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
		let payload = Box((application, userInfo, completionHandler))
		measured { [weak self, payload] in
			guard let self else {
				payload.value.2(.noData)
				return
			}

			app(
				payload.value.0,
				didReceiveRemoteNotification: payload.value.1,
				fetchCompletionHandler: payload.value.2
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
		let payload = Box((application, url, options))
		return measured { [weak self, payload] in
			guard let self else { return false }

			return app(
				payload.value.0,
				open: payload.value.1,
				options: payload.value.2
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
		let payload = Box((application, identifier, completionHandler))
		measured { [weak self, payload] in
			guard let self else {
				payload.value.2()
				return
			}

			app(
				payload.value.0,
				handleEventsForBackgroundURLSession: payload.value.1,
				completionHandler: payload.value.2
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
		let payload = Box((application, shortcutItem, completionHandler))
		measured { [weak self, payload] in
			guard let self else {
				payload.value.2(false)
				return
			}

			app(
				payload.value.0,
				performActionFor: payload.value.1,
				completionHandler: payload.value.2
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
		let applicationBox = Box(application)
		measured { [weak self, applicationBox] in
			guard let self else { return }

			appProtectedDataDidBecomeAvailable(applicationBox.value)
		}
	}

	open func appProtectedDataDidBecomeAvailable(_ application: UIApplication) {
		//
	}

	public func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
		let applicationBox = Box(application)
		measured { [weak self, applicationBox] in
			guard let self else { return }

			appProtectedDataWillBecomeUnavailable(applicationBox.value)
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
		let payload = Box((application, window))
		return measured { [weak self, payload] in
			guard let self else { return .all }

			return app(
				payload.value.0,
				supportedInterfaceOrientationsFor: payload.value.1
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
		let payload = Box((application, extensionPointIdentifier))
		return measured { [weak self, payload] in
			guard let self else { return true }

			return app(
				payload.value.0,
				shouldAllowExtensionPointIdentifier: payload.value.1
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
		let payload = Box((application, identifierComponents, coder))
		return measured { [weak self, payload] in
			guard let self else { return nil }

			return app(
				payload.value.0,
				viewControllerWithRestorationIdentifierPath: payload.value.1,
				coder: payload.value.2
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
		let payload = Box((application, coder))
		return measured { [weak self, payload] in
			guard let self else { return false }

			return app(
				payload.value.0,
				shouldSaveSecureApplicationState: payload.value.1
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
		let payload = Box((application, coder))
		return measured { [weak self, payload] in
			guard let self else { return false }

			return app(
				payload.value.0,
				shouldRestoreApplicationState: payload.value.1
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
		let payload = Box((application, userActivityType))
		return measured { [weak self, payload] in
			guard let self else { return false }

			return app(
				payload.value.0,
				willContinueUserActivityWithType: payload.value.1
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
		let payload = Box((application, userActivity, restorationHandler))
		return measured { [weak self, payload] in
			guard let self else { return false }

			return app(
				payload.value.0,
				continue: payload.value.1,
				restorationHandler: payload.value.2
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
		let payload = Box((application, userActivity))
		measured { [weak self, payload] in
			guard let self else { return }

			app(
				payload.value.0,
				didUpdate: payload.value.1
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
		let payload = Box((application, userActivityType, error))
		measured { [weak self, payload] in
			guard let self else { return }

			app(
				payload.value.0,
				didFailToContinueUserActivityWithType: payload.value.1,
				error: payload.value.2
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
		let payload = Box((application, cloudKitShareMetadata))
		measured { [weak self, payload] in
			guard let self else { return }

			app(
				payload.value.0,
				userDidAcceptCloudKitShareWith: payload.value.1
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
