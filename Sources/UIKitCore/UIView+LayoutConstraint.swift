//
//  UIView+LayoutConstraint.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - Anchor constraint builders

// MARK: ++ NSLayoutXAxisAnchor

public extension NSLayoutXAxisAnchor {
	@discardableResult
	func constraint(
		to anchor: NSLayoutXAxisAnchor,
		_ viewConstraint: UIView.Constraint
	) -> NSLayoutConstraint {
		let layoutConstraint: NSLayoutConstraint
		switch viewConstraint.relation {
		case .equal:
			layoutConstraint = constraint(equalTo: anchor, constant: viewConstraint.constant)
		case .greater:
			layoutConstraint = constraint(greaterThanOrEqualTo: anchor, constant: viewConstraint.constant)
		case .lesser:
			layoutConstraint = constraint(lessThanOrEqualTo: anchor, constant: viewConstraint.constant)
		}
		layoutConstraint.priority = viewConstraint.priority
		layoutConstraint.isActive = viewConstraint.activate
		return layoutConstraint
	}
}

// MARK: ++ NSLayoutYAxisAnchor

public extension NSLayoutYAxisAnchor {
	@discardableResult
	func constraint(
		to anchor: NSLayoutYAxisAnchor,
		_ viewConstraint: UIView.Constraint
	) -> NSLayoutConstraint {
		let layoutConstraint: NSLayoutConstraint
		switch viewConstraint.relation {
		case .equal:
			layoutConstraint = constraint(equalTo: anchor, constant: viewConstraint.constant)
		case .greater:
			layoutConstraint = constraint(greaterThanOrEqualTo: anchor, constant: viewConstraint.constant)
		case .lesser:
			layoutConstraint = constraint(lessThanOrEqualTo: anchor, constant: viewConstraint.constant)
		}
		layoutConstraint.priority = viewConstraint.priority
		layoutConstraint.isActive = viewConstraint.activate
		return layoutConstraint
	}
}

// MARK: ++ NSLayoutDimension

public extension NSLayoutDimension {
	@discardableResult
	func constraint(
		to anchor: NSLayoutDimension? = nil,
		_ viewConstraint: UIView.Constraint
	) -> NSLayoutConstraint? {
		let layoutConstraint: NSLayoutConstraint?
		if let anchor {
			switch viewConstraint.relation {
			case .equal:
				layoutConstraint = constraint(equalTo: anchor, constant: viewConstraint.constant)
			case .greater:
				layoutConstraint = constraint(greaterThanOrEqualTo: anchor, constant: viewConstraint.constant)
			case .lesser:
				layoutConstraint = constraint(lessThanOrEqualTo: anchor, constant: viewConstraint.constant)
			}
		} else {
			switch viewConstraint.relation {
			case .equal:
				layoutConstraint = constraint(equalToConstant: viewConstraint.constant)
			case .greater:
				layoutConstraint = constraint(greaterThanOrEqualToConstant: viewConstraint.constant)
			case .lesser:
				layoutConstraint = constraint(lessThanOrEqualToConstant: viewConstraint.constant)
			}
		}
		layoutConstraint?.priority = viewConstraint.priority
		layoutConstraint?.isActive = viewConstraint.activate
		return layoutConstraint
	}
}

#endif
