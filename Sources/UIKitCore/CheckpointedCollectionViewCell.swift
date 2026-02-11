//
//  CheckpointedCollectionViewCell.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import SwiftCore
import UIKit

// MARK: - CheckpointedCollectionViewCell

/// Base `UICollectionViewCell` for consistent identity and checkpointing.
/// Subclass and override the open `cell...` methods to customize behavior or add instrumentation.
open class CheckpointedCollectionViewCell: UICollectionViewCell,
										   Entity {
	// MARK: + Public scope

	public let identifier: UInt64

	// MARK: ++ Init

	public override init(frame: CGRect) {
		self.identifier = Self.nextID
		super.init(frame: frame)
		measured {
			initialize()
		}
	}

	public required init?(coder: NSCoder) {
		fatalError("CheckpointedCollectionViewCell must be instantiated with init(frame:)")
	}

	open func initialize() {
		//
	}

	// MARK: ++ Lifecycle hooks (for Step 2 instrumentation)

	public override func prepareForReuse() {
		super.prepareForReuse()
		measured {
			cellPrepareForReuse()
		}
	}

	open func cellPrepareForReuse() {
		//
	}
}

#endif
