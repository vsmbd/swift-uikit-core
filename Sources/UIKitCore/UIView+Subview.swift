//
//  UIView+Subview.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

public extension UIView {
	// MARK: + Private scope

	private typealias EdgeConstraint = (
		edge: UIView.Edge,
		constraint: NSLayoutConstraint?
	)

	private func alignBeginningEdge(
		_ view: UIView?,
		_ chainVector: UIView.ChainVector,
		_ padding: UIView.Constraint,
		superview: UIView
	) -> EdgeConstraint {
		let edge: UIView.Edge = chainVector.direction == .vertical
		? .top
		: .lead
		let layoutConstraint = superview.align(view, EdgeVector(edge, padding))
		return (edge, layoutConstraint)
	}

	private func alignEndingEdge(
		_ view: UIView?,
		_ chainVector: UIView.ChainVector,
		_ padding: UIView.Constraint,
		superview: UIView
	) -> EdgeConstraint {
		let edge: UIView.Edge = chainVector.direction == .vertical ? .bottom : .trail
		let layoutConstraint = superview.align(view, EdgeVector(edge, padding))
		return (edge, layoutConstraint)
	}

	private func alignOtherEdges(
		_ view: UIView?,
		_ chainVector: UIView.ChainVector,
		_ padding: UIView.Constraint,
		superview: UIView
	) -> UIView.EdgeConstraints? {
		let edges: [UIView.Edge] = chainVector.direction == .vertical ? [.lead, .trail] : [.top, .bottom]
		return superview.align(view, edges, padding)
	}

	// MARK: + Public scope
	@inlinable
	func add(_ subview: UIView?) {
		if let subview {
			addSubview(subview)
		}
	}

	@inlinable
	func add(_ subviews: [UIView?]?) {
		if let subviews {
			for subview in subviews {
				add(subview)
			}
		}
	}

	@discardableResult
	@inlinable
	func embed(
		_ subview: UIView?,
		_ constraint: Constraint = .equal
	) -> EdgeConstraints? {
		add(subview)
		return align(subview, Edge.all, constraint)
	}

	@discardableResult
	@inlinable
	func embed(
		_ subview: UIView?,
		_ edgeVectors: [EdgeVector]
	) -> EdgeConstraints? {
		add(subview)
		return align(subview, edgeVectors)
	}

	@discardableResult
	func embed(
		_ subviews: [UIView?]?,
		_ chainVector: ChainVector,
		_ padding: Constraint = .equal
	) -> [EdgeConstraints?]? {
		guard let subviews, !subviews.isEmpty else { return nil }
		add(subviews)
		var constraints: [EdgeConstraints?] = []
		var previousView: UIView?
		var previousEdgeConstraints: EdgeConstraints?

		for view in subviews {
			var edgeConstraints = alignOtherEdges(view, chainVector, padding, superview: self)

			if view == subviews.first {
				let result = alignBeginningEdge(view, chainVector, padding, superview: self)
				edgeConstraints?.set(result.edge, result.constraint)
			}

			if view == subviews.last {
				let result = alignEndingEdge(view, chainVector, padding, superview: self)
				edgeConstraints?.set(result.edge, result.constraint)
			}

			if let previousView, let view {
				let chained = previousView.chain(view, chainVector)
				switch chainVector.direction {
				case .vertical:
					edgeConstraints?.top = chained
					previousEdgeConstraints?.bottom = chained
				case .horizontal:
					edgeConstraints?.lead = chained
					previousEdgeConstraints?.trail = chained
				}
				if !constraints.isEmpty {
					switch chainVector.direction {
					case .vertical: constraints[constraints.count - 1]?.bottom = chained
					case .horizontal: constraints[constraints.count - 1]?.trail = chained
					}
				}
			}

			constraints.append(edgeConstraints)
			previousView = view
			previousEdgeConstraints = edgeConstraints
		}

		return constraints
	}
}

#endif
