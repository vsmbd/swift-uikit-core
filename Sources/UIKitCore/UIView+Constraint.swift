//
//  UIView+Constraint.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIView.Constraint

prefix operator >-
prefix operator -<

public extension UIView {
	struct Constraint: ExpressibleByIntegerLiteral,
					   ExpressibleByFloatLiteral,
					   Sendable {
		public enum Relation: Sendable {
			case equal
			case greater
			case lesser
		}

		private(set) var relation: Relation
		private(set) var constant: CGFloat
		private(set) var priority: UILayoutPriority
		private(set) var activate: Bool

		private init(
			_ relation: Relation,
			_ constant: CGFloat,
			_ priority: UILayoutPriority = .required,
			_ activate: Bool = true
		) {
			self.relation = relation
			self.constant = constant
			self.priority = priority
			self.activate = activate
		}

		public init(integerLiteral value: Int) {
			self.init(floatLiteral: Double(value))
		}

		public init(floatLiteral value: Double) {
			self.init(.equal, CGFloat(value))
		}

		@inlinable
		public static var equal: Self {
			.equal()
		}

		@inlinable
		public static var greater: Self {
			.greater()
		}

		@inlinable
		public static var lesser: Self {
			.lesser()
		}

		public static func equal(
			_ constant: CGFloat = .zero,
			priority: UILayoutPriority = .required,
			activate: Bool = true
		) -> Self {
			.init(.equal, constant, priority, activate)
		}

		public static func greater(
			_ constant: CGFloat = .zero,
			priority: UILayoutPriority = .required,
			activate: Bool = true
		) -> Self {
			.init(.greater, constant, priority, activate)
		}

		public static func lesser(
			_ constant: CGFloat = .zero,
			priority: UILayoutPriority = .required,
			activate: Bool = true
		) -> Self {
			.init(.lesser, constant, priority, activate)
		}

		public static prefix func -< (_ constraint: Self) -> Self {
			.lesser(constraint.constant)
		}

		public static prefix func >- (_ constraint: Self) -> Self {
			.greater(constraint.constant)
		}
	}
}

#endif
