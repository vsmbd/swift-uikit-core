//
//  UIView+ChainLayout.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIView chain (sequential layout)

public extension UIView {
	@discardableResult
	func chain(
		_ view: UIView?,
		_ chainVector: ChainVector
	) -> NSLayoutConstraint? {
		guard let view else { return nil }
		switch chainVector.direction {
		case .vertical:
			return view.headAnchor.constraint(to: footAnchor, chainVector.constraint)
		case .horizontal:
			return view.leadAnchor.constraint(to: trailAnchor, chainVector.constraint)
		}
	}

	@discardableResult
	static func chain(
		_ views: [UIView?]?,
		_ chainVector: ChainVector
	) -> [NSLayoutConstraint?]? {
		guard let views, !views.isEmpty else { return nil }
		var result: [NSLayoutConstraint?] = []
		var previous: UIView?
		for view in views {
			if let previous, let view {
				result.append(previous.chain(view, chainVector))
			}
			previous = view
		}
		return result
	}
}

#endif
