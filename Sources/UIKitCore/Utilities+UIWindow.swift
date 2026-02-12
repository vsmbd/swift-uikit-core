//
//  Utilities+UIWindow.swift
//  UIKitCore
//
//  Created by vsmbd on 12/02/26.
//

#if os(iOS) || os(tvOS)

import Foundation
import UIKit

// MARK: - UIWindow

public extension UIWindow {
	/// The app's key window, if any.
	/// Uses the foreground active scene on iOS 13+; falls back to the key window in the app's windows on iOS 12.
	static var keyWindow: UIWindow? {
		if #available(iOS 13.0, *) {
			let scenes = UIApplication.shared
				.connectedScenes
				.compactMap { $0 as? UIWindowScene }

			if #available(iOS 15.0, *) {
				return scenes
					.first { $0.activationState == .foregroundActive }?
					.keyWindow
				?? scenes.first?.keyWindow
			} else {
				return scenes.flatMap(\.windows)
					.first(where: \.isKeyWindow)
			}
		} else {
			return UIApplication.shared.windows
				.first(where: \.isKeyWindow)
		}
	}
}

#endif
