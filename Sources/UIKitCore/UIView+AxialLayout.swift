//
//  UIView+AxialLayout.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIView center (axial layout)

public extension UIView {
	@discardableResult
	func center(
		_ view: UIView?,
		_ axisVector: AxisVector
	) -> NSLayoutConstraint? {
		guard let view else { return nil }
		switch (axisVector.axis, axisVector.constraint) {
		case (.vertical, let axisConstraint):
			return verticalCenterAnchor.constraint(to: view.verticalCenterAnchor, axisConstraint)
		case (.horizontal, let axisConstraint):
			return horizontalCenterAnchor.constraint(to: view.horizontalCenterAnchor, axisConstraint)
		}
	}

	@discardableResult
	func center(
		_ view: UIView?,
		_ axisVectors: [AxisVector]
	) -> AxisConstraints? {
		guard let view, !axisVectors.isEmpty else { return nil }
		var result = AxisConstraints()
		for axisVector in axisVectors {
			let layoutConstraint = center(view, axisVector)
			result.set(axisVector.axis, layoutConstraint)
		}
		return result
	}

	@discardableResult
	func center(
		_ view: UIView?,
		_ axes: [Axis] = Axis.all,
		_ constraint: Constraint = .equal
	) -> AxisConstraints? {
		guard let view, !axes.isEmpty else { return nil }
		var result = AxisConstraints()
		for axis in axes {
			let axisVector = AxisVector(axis, constraint)
			let layoutConstraint = center(view, axisVector)
			result.set(axis, layoutConstraint)
		}
		return result
	}

	@discardableResult
	func center(
		_ view: UIView?,
		_ axis: Axis,
		_ constraint: Constraint = .equal
	) -> NSLayoutConstraint? {
		center(view, AxisVector(axis, constraint))
	}

	@discardableResult
	func center(
		_ views: [UIView?]?,
		_ axis: Axis,
		_ constraint: Constraint = .equal
	) -> [NSLayoutConstraint?]? {
		guard let views, !views.isEmpty else { return nil }
		var result: [NSLayoutConstraint?] = []
		let axisVector = AxisVector(axis, constraint)
		for view in views {
			result.append(center(view, axisVector))
		}
		return result
	}
}

#endif
