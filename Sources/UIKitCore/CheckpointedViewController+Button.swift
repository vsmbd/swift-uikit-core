//
//  CheckpointedViewController+Button.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - CheckpointedViewController + Button

public extension CheckpointedViewController {
	// MARK: + Public scope

	/// Returns the checkpointed button for `id`, creating and caching one if it doesn't exist.
	func button(id: String) -> CheckpointedButton {
		measured {
			if let existing = buttons[id] {
				return existing
			}
			let button = CheckpointedButton(viewId: id)
			buttons[id] = button
			return button
		}
	}
}

#endif
