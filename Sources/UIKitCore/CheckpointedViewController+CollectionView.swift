//
//  CheckpointedViewController+CollectionView.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - CheckpointedViewController + CollectionView

public extension CheckpointedViewController {
	// MARK: + Public scope

	/// Returns the checkpointed collection view for `id`, creating and caching one if it doesn't exist.
	/// Add to the view hierarchy, set delegate/dataSource, and configure as needed.
	func collectionView(id: String) -> CheckpointedCollectionView {
		measured {
			if let existing = checkpointedCollectionViews[id] {
				return existing
			}
			let collectionView = CheckpointedCollectionView(viewId: id)
			checkpointedCollectionViews[id] = collectionView
			return collectionView
		}
	}
}

#endif
