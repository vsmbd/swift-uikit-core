//
//  CheckpointedViewController+Table.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: - CheckpointedViewController + Table

public extension CheckpointedViewController {
	// MARK: + Public scope

	/// Returns the checkpointed table view for `id`, creating and caching one if it doesn't exist.
	/// Add to the view hierarchy, set delegate/dataSource, and configure as needed.
	func table(id: String) -> CheckpointedTableView {
		measured {
			if let existing = tables[id] {
				return existing
			}
			let table = CheckpointedTableView(viewId: id)
			tables[id] = table
			return table
		}
	}
}

#endif
