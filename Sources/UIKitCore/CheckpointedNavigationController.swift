//
//  CheckpointedNavigationController.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import SwiftCore
import UIKit

// MARK: - CheckpointedNavigationController

/// Base `UINavigationController` for consistent identity and checkpointing at navigation events.
/// Subclass and override the open `nav...` methods to customize behavior or add instrumentation.
open class CheckpointedNavigationController: UINavigationController,
											 Entity {
	// MARK: + Public scope

	public let identifier: UInt64

	// MARK: ++ Init

	public override init(rootViewController: UIViewController) {
		self.identifier = Self.nextID
		super.init(rootViewController: rootViewController)
		measured {
			initialize()
		}
	}

	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		fatalError("CheckpointedNavigationController must be instantiated with init(rootViewController:)")
	}

	public required init?(coder: NSCoder) {
		fatalError("CheckpointedNavigationController must be instantiated with init(rootViewController:)")
	}

	open func initialize() {
		//
	}

	// MARK: ++ Navigation

	public override func pushViewController(
		_ viewController: UIViewController,
		animated: Bool
	) {
		measured {
			navPush(
				viewController,
				animated: animated
			)
		}
	}

	open func navPush(
		_ viewController: UIViewController,
		animated: Bool
	) {
		super.pushViewController(
			viewController,
			animated: animated
		)
	}

	@discardableResult
	public override func popViewController(animated: Bool) -> UIViewController? {
		measured {
			navPop(animated: animated)
		}
	}

	open func navPop(animated: Bool) -> UIViewController? {
		super.popViewController(animated: animated)
	}

	public override func setViewControllers(
		_ viewControllers: [UIViewController],
		animated: Bool
	) {
		measured {
			navSetViewControllers(
				viewControllers,
				animated: animated
			)
		}
	}

	open func navSetViewControllers(
		_ viewControllers: [UIViewController],
		animated: Bool
	) {
		super.setViewControllers(
			viewControllers,
			animated: animated
		)
	}
}

#endif
