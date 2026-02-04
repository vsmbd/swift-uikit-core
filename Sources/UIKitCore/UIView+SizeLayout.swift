//
//  UIView+SizeLayout.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIView size (match, fix, height, width)

public extension UIView {
	@discardableResult
	func matchSize(
		_ view: UIView?,
		_ sizeVector: SizeVector
	) -> NSLayoutConstraint? {
		guard let view else { return nil }
		switch (sizeVector.size, sizeVector.constraint) {
		case (.height, let axisConstraint):
			return heightAnchor.constraint(to: view.heightAnchor, axisConstraint)
		case (.width, let axisConstraint):
			return widthAnchor.constraint(to: view.widthAnchor, axisConstraint)
		}
	}

	@discardableResult
	func matchSize(
		_ view: UIView?,
		_ sizeVectors: [SizeVector]
	) -> SizeConstraints? {
		guard let view, !sizeVectors.isEmpty else { return nil }
		var result = SizeConstraints()
		for sizeVector in sizeVectors {
			let layoutConstraint = matchSize(view, sizeVector)
			result.set(sizeVector.size, layoutConstraint)
		}
		return result
	}

	@discardableResult
	func matchSize(
		_ view: UIView?,
		_ sizes: [Size] = Size.all,
		_ constraint: Constraint = .equal
	) -> SizeConstraints? {
		guard let view, !sizes.isEmpty else { return nil }
		var result = SizeConstraints()
		for size in sizes {
			let sizeVector = SizeVector(size, constraint)
			let layoutConstraint = matchSize(view, sizeVector)
			result.set(size, layoutConstraint)
		}
		return result
	}

	@discardableResult
	func matchSize(
		_ view: UIView?,
		_ constraint: Constraint = .equal
	) -> SizeConstraints? {
		matchSize(view, Size.all, constraint)
	}

	@discardableResult
	func fixSize(_ sizeVector: SizeVector) -> NSLayoutConstraint? {
		switch (sizeVector.size, sizeVector.constraint) {
		case (.height, let axisConstraint):
			return heightAnchor.constraint(to: nil, axisConstraint)
		case (.width, let axisConstraint):
			return widthAnchor.constraint(to: nil, axisConstraint)
		}
	}

	@discardableResult
	func fixSize(_ sizeVectors: [SizeVector]) -> SizeConstraints? {
		guard !sizeVectors.isEmpty else { return nil }
		var result = SizeConstraints()
		for sizeVector in sizeVectors {
			let layoutConstraint = fixSize(sizeVector)
			result.set(sizeVector.size, layoutConstraint)
		}
		return result
	}

	@discardableResult
	func fixSize(
		_ axes: [Size] = Size.all,
		_ constraint: Constraint = .equal
	) -> SizeConstraints? {
		guard !axes.isEmpty else { return nil }
		var result = SizeConstraints()
		for axis in axes {
			let sizeVector = SizeVector(axis, constraint)
			let layoutConstraint = fixSize(sizeVector)
			result.set(axis, layoutConstraint)
		}
		return result
	}

	@discardableResult
	func height(_ sizeConstraint: Constraint = .equal) -> NSLayoutConstraint? {
		fixSize(SizeVector(.height, sizeConstraint))
	}

	@discardableResult
	func height(_ sizeConstraints: [Constraint]) -> [NSLayoutConstraint?]? {
		guard !sizeConstraints.isEmpty else { return nil }
		return sizeConstraints.map { height($0) }
	}

	@discardableResult
	func width(_ sizeConstraint: Constraint = .equal) -> NSLayoutConstraint? {
		fixSize(SizeVector(.width, sizeConstraint))
	}

	@discardableResult
	func width(_ sizeConstraints: [Constraint]) -> [NSLayoutConstraint?]? {
		guard !sizeConstraints.isEmpty else { return nil }
		return sizeConstraints.map { width($0) }
	}
}

#endif
