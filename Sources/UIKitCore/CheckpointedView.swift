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
							 Entity {
	// MARK: + Public scope

	public let identifier: UInt64

	// MARK: ++ Init

	public init() {
		self.identifier = Self.nextID

		super.init(frame: .zero)

		translatesAutoresizingMaskIntoConstraints = false
		clipsToBounds = true
		backgroundColor = .clear

		measured {
			initialize()
		}
	}

	open func initialize() {
		//
	}

	public override init(frame: CGRect) {
		fatalError("CheckpointedView must be instantiated programmatically init()")
	}

	public required init?(coder: NSCoder) {
		fatalError("CheckpointedView must be instantiated programmatically init()")
	}

	// MARK: ++ Layout

	public override func layoutSubviews() {
		super.layoutSubviews()
		measured {
			vwLayoutSubviews()
		}
	}

	open func vwLayoutSubviews() {
		//
	}

	public override func updateConstraints() {
		super.updateConstraints()
		measured {
			vwUpdateConstraints()
		}
	}

	open func vwUpdateConstraints() {
		//
	}

	// MARK: ++ Drawing

	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		measured {
			vwDraw(rect)
		}
	}

	open func vwDraw(_ rect: CGRect) {
		//
	}

	// MARK: ++ Sizing

	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		measured {
			vwSizeThatFits(size)
		}
	}

	open func vwSizeThatFits(_ size: CGSize) -> CGSize {
		return super.sizeThatFits(size)
	}

	// MARK: ++ Superview

	public override func didMoveToSuperview() {
		super.didMoveToSuperview()
		measured {
			vwDidMoveToSuperview()
		}
	}

	open func vwDidMoveToSuperview() {
		//
	}

	public override func willMove(toSuperview newSuperview: UIView?) {
		super.willMove(toSuperview: newSuperview)
		measured {
			vwWillMove(toSuperview: newSuperview)
		}
	}

	open func vwWillMove(toSuperview newSuperview: UIView?) {
		//
	}

	// MARK: ++ Window

	public override func didMoveToWindow() {
		super.didMoveToWindow()
		measured {
			vwDidMoveToWindow()
		}
	}

	open func vwDidMoveToWindow() {
		//
	}

	public override func willMove(toWindow newWindow: UIWindow?) {
		super.willMove(toWindow: newWindow)
		measured {
			vwWillMove(toWindow: newWindow)
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
		measured {
			vwPoint(
				inside: point,
				with: event
			)
		}
	}

	open func vwPoint(
		inside point: CGPoint,
		with event: UIEvent?
	) -> Bool {
		super.point(
			inside: point,
			with: event
		)
	}

	public override func hitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		measured {
			vwHitTest(
				point,
				with: event
			)
		}
	}

	open func vwHitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		super.hitTest(
			point,
			with: event
		)
	}

	// MARK: ++ Traits

	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		measured {
			vwTraitCollectionDidChange(previousTraitCollection)
		}
	}

	open func vwTraitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		//
	}
}

#endif
