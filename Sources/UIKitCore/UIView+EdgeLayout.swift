//
//  UIView+EdgeLayout.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIView align (edge layout)

public extension UIView {
	@discardableResult
	func align(
		_ subview: UIView?,
		_ edgeVector: EdgeVector
	) -> NSLayoutConstraint? {
		guard let subview else { return nil }
		let constraint: NSLayoutConstraint?
		switch (edgeVector.edge, edgeVector.constraint) {
		case (.lead, let axisConstraint):
			constraint = subview.leadAnchor.constraint(to: leadAnchor, axisConstraint)
		case (.trail, let axisConstraint):
			constraint = trailAnchor.constraint(to: subview.trailAnchor, axisConstraint)
		case (.top, let axisConstraint):
			constraint = subview.headAnchor.constraint(to: headAnchor, axisConstraint)
		case (.bottom, let axisConstraint):
			constraint = footAnchor.constraint(to: subview.footAnchor, axisConstraint)
		}
		return constraint
	}

	@discardableResult
	func align(
		_ subview: UIView?,
		_ edgeVectors: [EdgeVector]
	) -> EdgeConstraints? {
		guard let subview, !edgeVectors.isEmpty else { return nil }
		var constraints = EdgeConstraints()
		for edgeVector in edgeVectors {
			let layoutConstraint = align(subview, edgeVector)
			constraints.set(edgeVector.edge, layoutConstraint)
		}
		return constraints
	}

	@discardableResult
	func align(
		_ subview: UIView?,
		_ edges: [Edge] = Edge.all,
		_ constraint: Constraint = .equal
	) -> EdgeConstraints? {
		guard let subview, !edges.isEmpty else { return nil }
		var result = EdgeConstraints()
		for edge in edges {
			let edgeVector = EdgeVector(edge, constraint)
			let layoutConstraint = align(subview, edgeVector)
			result.set(edge, layoutConstraint)
		}
		return result
	}
}

#endif
