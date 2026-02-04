//
//  UIView+Anchor.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - UIView layout anchors (safe-area–aware)

public extension UIView {
	@inlinable
	var leadAnchor: NSLayoutXAxisAnchor {
		safeAreaLayoutGuide.leadingAnchor
	}

	@inlinable
	var trailAnchor: NSLayoutXAxisAnchor {
		safeAreaLayoutGuide.trailingAnchor
	}

	@inlinable
	var headAnchor: NSLayoutYAxisAnchor {
		safeAreaLayoutGuide.topAnchor
	}

	@inlinable
	var footAnchor: NSLayoutYAxisAnchor {
		safeAreaLayoutGuide.bottomAnchor
	}

	@inlinable
	var horizontalCenterAnchor: NSLayoutXAxisAnchor {
		centerXAnchor
	}

	@inlinable
	var verticalCenterAnchor: NSLayoutYAxisAnchor {
		centerYAnchor
	}
}

#endif
