//
//  UIView+Instance.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIView instance and bgColor

public extension UIView {
	@inlinable
	var bgColor: UIColor? {
		get { backgroundColor }
		set { backgroundColor = newValue }
	}

	@inlinable
	static func instance() -> Self {
		let instance = Self(frame: .zero)
		instance.translatesAutoresizingMaskIntoConstraints = false
		instance.clipsToBounds = true
		instance.backgroundColor = .clear
		return instance
	}
}

#endif
