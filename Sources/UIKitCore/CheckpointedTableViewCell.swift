//
//  CheckpointedTableViewCell.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import SwiftCore
import UIKit

// MARK: - CheckpointedTableViewCell

/// Base `UITableViewCell` for consistent identity and checkpointing.
/// Subclass and override the open `cell...` methods to customize behavior or add instrumentation.
open class CheckpointedTableViewCell: UITableViewCell,
									 Entity {
	// MARK: + Public scope

	public let identifier: UInt64

	// MARK: ++ Init

	public override init(
		style: UITableViewCell.CellStyle,
		reuseIdentifier: String?
	) {
		self.identifier = Self.nextID
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		measured {
			initialize()
		}
	}

	public required init?(coder: NSCoder) {
		fatalError("CheckpointedTableViewCell must be instantiated with init(style:reuseIdentifier:)")
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

	public override func setSelected(
		_ selected: Bool,
		animated: Bool
	) {
		super.setSelected(selected, animated: animated)
		measured {
			cellSetSelected(selected, animated: animated)
		}
	}

	open func cellSetSelected(_ selected: Bool, animated: Bool) {
		//
	}
}

#endif
