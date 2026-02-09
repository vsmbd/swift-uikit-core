//
//  UIView+Axis.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIView.Axis and AxisVector

public extension UIView {
	enum Axis: Sendable {
		case vertical
		case horizontal

		public static let all: [Self] = [.vertical, .horizontal]
	}

	struct AxisVector: Sendable {
		private(set) var axis: Axis
		private(set) var constraint: Constraint

		init(_ axis: Axis, _ constraint: Constraint = .equal) {
			self.axis = axis
			self.constraint = constraint
		}

		@inlinable
		public static var vertical: Self { vertical() }

		@inlinable
		public static var horizontal: Self { horizontal() }

		public static func vertical(_ constraint: Constraint = .equal) -> Self {
			.init(.vertical, constraint)
		}

		public static func horizontal(_ constraint: Constraint = .equal) -> Self {
			.init(.horizontal, constraint)
		}
	}

	struct AxisConstraints: Sendable {
		public var vertical: NSLayoutConstraint?
		public var horizontal: NSLayoutConstraint?

		@MainActor
		public var activate: Bool = false {
			didSet {
				vertical?.isActive = activate
				horizontal?.isActive = activate
			}
		}

		mutating func set(_ axis: Axis, _ constraint: NSLayoutConstraint?) {
			switch axis {
			case .vertical: vertical = constraint
			case .horizontal: horizontal = constraint
			}
		}
	}
}

#endif
