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
	// MARK: + Public scope

	public let identifier: UInt64

	// MARK: ++ Init

	public init() {
		self.identifier = Self.nextID
		super.init(nibName: nil, bundle: nil)
		measured { [weak self] in
			guard let self else { return }

			initialize()
		}
	}

	nonisolated open func initialize() {
		//
	}

	public override init(
		nibName nibNameOrNil: String?,
		bundle nibBundleOrNil: Bundle?
	) {
		fatalError("CheckpointedViewController must be instantiated programmatically (init())")
	}

	public required init?(coder: NSCoder) {
		fatalError("CheckpointedViewController must be instantiated programmatically (init())")
	}

	// MARK: ++ View loading

	public override func loadView() {
		super.loadView()
		measured { [weak self] in
			guard let self else { return }

			vcLoadView()
		}
	}

	nonisolated open func vcLoadView() {
		//
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		measured { [weak self] in
			guard let self else { return }

			vcViewDidLoad()
		}
	}

	nonisolated open func vcViewDidLoad() {
		//
	}

	// MARK: ++ View appearance

	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		measured { [weak self] in
			guard let self else { return }

			vcViewWillAppear(animated)
		}
	}

	nonisolated open func vcViewWillAppear(_ animated: Bool) {
		//
	}

	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		measured { [weak self] in
			guard let self else { return }

			vcViewDidAppear(animated)
		}
	}

	nonisolated open func vcViewDidAppear(_ animated: Bool) {
		//
	}

	public override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		measured { [weak self] in
			guard let self else { return }

			vcViewWillDisappear(animated)
		}
	}

	nonisolated open func vcViewWillDisappear(_ animated: Bool) {
		//
	}

	public override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		measured { [weak self] in
			guard let self else { return }

			vcViewDidDisappear(animated)
		}
	}

	nonisolated open func vcViewDidDisappear(_ animated: Bool) {
		//
	}

	// MARK: ++ Layout

	public override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		measured { [weak self] in
			guard let self else { return }

			vcViewWillLayoutSubviews()
		}
	}

	nonisolated open func vcViewWillLayoutSubviews() {
		//
	}

	public override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		measured { [weak self] in
			guard let self else { return }

			vcViewDidLayoutSubviews()
		}
	}

	nonisolated open func vcViewDidLayoutSubviews() {
		//
	}

	public override func updateViewConstraints() {
		super.updateViewConstraints()
		measured { [weak self] in
			guard let self else { return }

			vcUpdateViewConstraints()
		}
	}

	nonisolated open func vcUpdateViewConstraints() {
		//
	}

	// MARK: ++ Transition

	public override func viewWillTransition(
		to size: CGSize,
		with coordinator: UIViewControllerTransitionCoordinator
	) {
		super.viewWillTransition(to: size, with: coordinator)
		let payload = Box((size, coordinator))
		measured { [weak self, payload] in
			guard let self else { return }

			vcViewWillTransition(
				to: payload.value.0,
				with: payload.value.1
			)
		}
	}

	nonisolated open func vcViewWillTransition(
		to size: CGSize,
		with coordinator: UIViewControllerTransitionCoordinator
	) {
		//
	}

	// MARK: ++ View appearing (iOS 13+)

	@available(iOS 13.0, *)
	public override func viewIsAppearing(_ appearing: Bool) {
		super.viewIsAppearing(appearing)
		measured { [weak self] in
			guard let self else { return }

			vcViewIsAppearing(appearing)
		}
	}

	@available(iOS 13.0, *)
	nonisolated open func vcViewIsAppearing(_ appearing: Bool) {
		//
	}

	// MARK: ++ Memory

	public override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		measured { [weak self] in
			guard let self else { return }

			vcDidReceiveMemoryWarning()
		}
	}

	nonisolated open func vcDidReceiveMemoryWarning() {
		//
	}

	// MARK: ++ Parent

	public override func willMove(toParent parent: UIViewController?) {
		super.willMove(toParent: parent)
		let parentBox = Box(parent)
		measured { [weak self, parentBox] in
			guard let self else { return }

			vcWillMove(toParent: parentBox.value)
		}
	}

	nonisolated open func vcWillMove(toParent parent: UIViewController?) {
		//
	}

	public override func didMove(toParent parent: UIViewController?) {
		super.didMove(toParent: parent)
		let parentBox = Box(parent)
		measured { [weak self, parentBox] in
			guard let self else { return }

			vcDidMove(toParent: parentBox.value)
		}
	}

	nonisolated open func vcDidMove(toParent parent: UIViewController?) {
		//
	}

	// MARK: ++ Traits

	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		let traitBox = Box(previousTraitCollection)
		measured { [weak self, traitBox] in
			guard let self else { return }

			vcTraitCollectionDidChange(traitBox.value)
		}
	}

	nonisolated open func vcTraitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		//
	}
}

#endif
