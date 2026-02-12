//
//  CheckpointedViewController+Label.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - CheckpointedViewController + Label

public extension CheckpointedViewController {
	// MARK: + Public scope

	/// Returns the checkpointed label for `id`, creating and caching one if it doesn't exist.
	/// Add to the view hierarchy and configure as needed.
	func label(id: String) -> CheckpointedLabel {
		measured {
			if let existing = labels[id] {
				return existing
			}
			let label = CheckpointedLabel(viewId: id)
			labels[id] = label
			return label
		}
	}
}

#endif
