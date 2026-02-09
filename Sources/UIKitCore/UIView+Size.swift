//
//  UIView+Size.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIView.Size and SizeVector

public extension UIView {
	enum Size: Sendable {
		case height
		case width

		public static let all: [Self] = [.height, .width]
	}

	struct SizeVector: Sendable {
		private(set) var size: Size
		private(set) var constraint: Constraint

		init(_ size: Size, _ constraint: Constraint = .equal) {
			self.size = size
			self.constraint = constraint
		}

		@inlinable
		public static var height: Self { height() }

		@inlinable
		public static var width: Self { width() }

		public static func height(_ constraint: Constraint = .equal) -> Self {
			.init(.height, constraint)
		}

		public static func width(_ constraint: Constraint = .equal) -> Self {
			.init(.width, constraint)
		}
	}

	struct SizeConstraints: Sendable {
		public var height: NSLayoutConstraint?
		public var width: NSLayoutConstraint?

		@MainActor
		public var activate: Bool = false {
			didSet {
				height?.isActive = activate
				width?.isActive = activate
			}
		}

		mutating func set(_ size: Size, _ constraint: NSLayoutConstraint?) {
			switch size {
			case .height: height = constraint
			case .width: width = constraint
			}
		}
	}
}

#endif
