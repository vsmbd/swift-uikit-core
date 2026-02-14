//
//  UIScrollView+Content.swift
//  UIKitCore
//
//  Created by vsmbd on 14/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIScrollView add (content view)

public extension UIScrollView {
	/// Adds `subview` as a subview and pins it to `contentLayoutGuide` on all four edges.
	/// Returns the edge constraints (lead, trail, top, bottom), or `nil` if `subview` is nil.
	@discardableResult
	func addContentView(_ subview: UIView?) -> UIView.EdgeConstraints? {
		guard let subview else { return nil }

		addSubview(subview)

		let contentGuide = contentLayoutGuide
		var constraints = UIView.EdgeConstraints()

		constraints.lead = subview.leadingAnchor
			.constraint(equalTo: contentGuide.leadingAnchor)
		constraints.trail = contentGuide.trailingAnchor
			.constraint(equalTo: subview.trailingAnchor)
		constraints.top = subview.topAnchor
			.constraint(equalTo: contentGuide.topAnchor)
		constraints.bottom = contentGuide.bottomAnchor
			.constraint(equalTo: subview.bottomAnchor)

		constraints.activate = true

		return constraints
	}
}

#endif
