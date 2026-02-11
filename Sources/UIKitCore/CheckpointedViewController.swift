//
//  CheckpointedViewController.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import SwiftCore
import UIKit

// MARK: - CheckpointedViewController

/// Base `UIViewController` for consistent view lifecycle and checkpointing.
/// Subclass and override the open `vc...` methods to customize behavior.
open class CheckpointedViewController: UIViewController,
									   Entity {
	// MARK: + Default scope

	/// Buttons keyed by id. Use `button(id:)` to get or create.
	var checkpointedButtons: [String: CheckpointedButton] = [:]
	/// Labels keyed by id. Use `label(id:)` to get or create.
	var checkpointedLabels: [String: CheckpointedLabel] = [:]
	/// Table views keyed by id. Use `table(id:)` to get or create.
	var checkpointedTables: [String: CheckpointedTableView] = [:]
	/// Collection views keyed by id. Use `collectionView(id:)` to get or create.
	var checkpointedCollectionViews: [String: CheckpointedCollectionView] = [:]

	// MARK: + Public scope

	public let identifier: UInt64

	/// Logical id for this view controller. Immutable after init.
	public let viewId: String

	// MARK: ++ Init

	public init(viewId: String) {
		self.viewId = viewId
		self.identifier = Self.nextID
		super.init(
			nibName: nil,
			bundle: nil
		)
		measured {
			initialize()
		}
	}

	open func initialize() {
		//
	}

	public override init(
		nibName nibNameOrNil: String?,
		bundle nibBundleOrNil: Bundle?
	) {
		fatalError("CheckpointedViewController must be instantiated with init(viewId:)")
	}

	public required init?(coder: NSCoder) {
		fatalError("CheckpointedViewController must be instantiated with init(viewId:)")
	}

	// MARK: ++ View loading

	public override func loadView() {
		super.loadView()
		measured {
			vcLoadView()
		}
	}

	open func vcLoadView() {
		//
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		measured {
			vcViewDidLoad()
		}
	}

	open func vcViewDidLoad() {
		//
	}

	// MARK: ++ View appearance

	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		measured {
			vcViewWillAppear(animated)
		}
	}

	open func vcViewWillAppear(_ animated: Bool) {
		//
	}

	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		measured {
			vcViewDidAppear(animated)
		}
	}

	open func vcViewDidAppear(_ animated: Bool) {
		//
	}

	public override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		measured {
			vcViewWillDisappear(animated)
		}
	}

	open func vcViewWillDisappear(_ animated: Bool) {
		//
	}

	public override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		measured {
			vcViewDidDisappear(animated)
		}
	}

	open func vcViewDidDisappear(_ animated: Bool) {
		//
	}

	// MARK: ++ Layout

	public override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		measured {
			vcViewWillLayoutSubviews()
		}
	}

	open func vcViewWillLayoutSubviews() {
		//
	}

	public override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		measured {
			vcViewDidLayoutSubviews()
		}
	}

	open func vcViewDidLayoutSubviews() {
		//
	}

	public override func updateViewConstraints() {
		super.updateViewConstraints()
		measured {
			vcUpdateViewConstraints()
		}
	}

	open func vcUpdateViewConstraints() {
		//
	}

	// MARK: ++ Transition

	public override func viewWillTransition(
		to size: CGSize,
		with coordinator: UIViewControllerTransitionCoordinator
	) {
		super.viewWillTransition(to: size, with: coordinator)
		measured {
			vcViewWillTransition(
				to: size,
				with: coordinator
			)
		}
	}

	open func vcViewWillTransition(
		to size: CGSize,
		with coordinator: UIViewControllerTransitionCoordinator
	) {
		//
	}

	// MARK: ++ View appearing (iOS 13+)

	@available(iOS 13.0, *)
	public override func viewIsAppearing(_ appearing: Bool) {
		super.viewIsAppearing(appearing)
		measured {
			vcViewIsAppearing(appearing)
		}
	}

	@available(iOS 13.0, *)
	open func vcViewIsAppearing(_ appearing: Bool) {
		//
	}

	// MARK: ++ Memory

	public override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		measured {
			vcDidReceiveMemoryWarning()
		}
	}

	open func vcDidReceiveMemoryWarning() {
		//
	}

	// MARK: ++ Parent

	public override func willMove(toParent parent: UIViewController?) {
		super.willMove(toParent: parent)
		measured {
			vcWillMove(toParent: parent)
		}
	}

	open func vcWillMove(toParent parent: UIViewController?) {
		//
	}

	public override func didMove(toParent parent: UIViewController?) {
		super.didMove(toParent: parent)
		measured {
			vcDidMove(toParent: parent)
		}
	}

	open func vcDidMove(toParent parent: UIViewController?) {
		//
	}

	// MARK: ++ Traits

	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		measured {
			vcTraitCollectionDidChange(previousTraitCollection)
		}
	}

	open func vcTraitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		//
	}
}

#endif
