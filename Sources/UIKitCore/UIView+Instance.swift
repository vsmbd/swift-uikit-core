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
}

#endif
