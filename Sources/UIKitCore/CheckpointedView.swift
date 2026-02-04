//
//  CheckpointedView.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import SwiftCore
import UIKit

// MARK: - CheckpointedView

/// Base `UIView` for consistent view lifecycle and checkpointing.
/// Subclass and override the open `vw...` methods to customize behavior.
open class CheckpointedView: UIView,
							 Entity,
							 @unchecked Sendable {
	// MARK: + Public scope

	public let identifier: UInt64

	// MARK: ++ Init

	public override init(frame: CGRect) {
		self.identifier = Self.nextID
		super.init(frame: frame)
		measured { [weak self] in
			guard let self else { return }

			initialize()
		}
	}

	open func initialize() {
		//
	}

	public required init?(coder: NSCoder) {
		fatalError("CheckpointedView must be instantiated programmatically (init(frame:))")
	}

	// MARK: ++ Layout

	public override func layoutSubviews() {
		super.layoutSubviews()
		measured { [weak self] in
			guard let self else { return }

			vwLayoutSubviews()
		}
	}

	open func vwLayoutSubviews() {
		//
	}

	public override func updateConstraints() {
		super.updateConstraints()
		measured { [weak self] in
			guard let self else { return }

			vwUpdateConstraints()
		}
	}

	open func vwUpdateConstraints() {
		//
	}

	// MARK: ++ Drawing

	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		measured { [weak self] in
			guard let self else { return }

			vwDraw(rect)
		}
	}

	open func vwDraw(_ rect: CGRect) {
		//
	}

	// MARK: ++ Sizing

	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		let base = super.sizeThatFits(size)
		return measured { [weak self] in
			guard let self else { return base }

			return vwSizeThatFits(size)
		}
	}

	open func vwSizeThatFits(_ size: CGSize) -> CGSize {
		return super.sizeThatFits(size)
	}

	// MARK: ++ Superview

	public override func didMoveToSuperview() {
		super.didMoveToSuperview()
		measured { [weak self] in
			guard let self else { return }

			vwDidMoveToSuperview()
		}
	}

	open func vwDidMoveToSuperview() {
		//
	}

	public override func willMove(toSuperview newSuperview: UIView?) {
		super.willMove(toSuperview: newSuperview)
		let superviewBox = Box(newSuperview)
		measured { [weak self, superviewBox] in
			guard let self else { return }

			vwWillMove(toSuperview: superviewBox.value)
		}
	}

	open func vwWillMove(toSuperview newSuperview: UIView?) {
		//
	}

	// MARK: ++ Window

	public override func didMoveToWindow() {
		super.didMoveToWindow()
		measured { [weak self] in
			guard let self else { return }

			vwDidMoveToWindow()
		}
	}

	open func vwDidMoveToWindow() {
		//
	}

	public override func willMove(toWindow newWindow: UIWindow?) {
		super.willMove(toWindow: newWindow)
		let windowBox = Box(newWindow)
		measured { [weak self, windowBox] in
			guard let self else { return }

			vwWillMove(toWindow: windowBox.value)
		}
	}

	open func vwWillMove(toWindow newWindow: UIWindow?) {
		//
	}

	// MARK: ++ Hit testing

	public override func point(
		inside point: CGPoint,
		with event: UIEvent?
	) -> Bool {
		let payload = Box((point, event))
		return measured { [weak self, payload] in
			guard let self else { return false }

			return vwPoint(
				inside: payload.value.0,
				with: payload.value.1
			)
		}
	}

	open func vwPoint(
		inside point: CGPoint,
		with event: UIEvent?
	) -> Bool {
		return super.point(inside: point, with: event)
	}

	public override func hitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		let payload = Box((point, event))
		return measured { [weak self, payload] in
			guard let self else { return nil }

			return vwHitTest(
				payload.value.0,
				with: payload.value.1
			)
		}
	}

	open func vwHitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		return super.hitTest(point, with: event)
	}

	// MARK: ++ Traits

	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		let traitBox = Box(previousTraitCollection)
		measured { [weak self, traitBox] in
			guard let self else { return }

			vwTraitCollectionDidChange(traitBox.value)
		}
	}

	open func vwTraitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		//
	}
}

#endif
