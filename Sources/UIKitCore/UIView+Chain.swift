//
//  UIView+Chain.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIView.ChainVector

public extension UIView {
	enum ChainDirection: Sendable {
		case vertical
		case horizontal
	}

	struct ChainVector: Sendable {
		private(set) var direction: ChainDirection
		private(set) var constraint: Constraint

		init(_ direction: ChainDirection, _ constraint: Constraint = .equal) {
			self.direction = direction
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
}

#endif
