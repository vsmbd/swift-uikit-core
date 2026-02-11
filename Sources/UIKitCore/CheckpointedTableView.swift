//
//  CheckpointedTableView.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import SwiftCore
import UIKit

// MARK: - CheckpointedTableView

/// Base `UITableView` for consistent identity and checkpointing.
/// Subclass and override the open `tbl...` methods to customize behavior or add instrumentation.
open class CheckpointedTableView: UITableView,
								  Entity {
	// MARK: + Public scope

	public let identifier: UInt64

	/// Logical id for this table (e.g. from `CheckpointedViewController.table(id:)`). Immutable after init.
	public let viewId: String

	// MARK: ++ Init

	public convenience init(viewId: String) {
		self.init(viewId: viewId, frame: .zero, style: .plain)
	}

	public init(
		viewId: String,
		frame: CGRect,
		style: UITableView.Style
	) {
		self.viewId = viewId
		self.identifier = Self.nextID
		super.init(frame: frame, style: style)
		translatesAutoresizingMaskIntoConstraints = false
		measured {
			initialize()
		}
	}

	public override init(frame: CGRect, style: UITableView.Style) {
		fatalError("CheckpointedTableView must be instantiated with init(viewId:) or init(viewId:frame:style:)")
	}

	public required init?(coder: NSCoder) {
		fatalError(
			"CheckpointedTableView must be instantiated with init(viewId:) or init(viewId:frame:style:)"
		)
	}

	open func initialize() {
		//
	}

	// MARK: ++ Selection hooks (for Step 2 instrumentation)

	public override func deselectRow(
		at indexPath: IndexPath,
		animated: Bool
	) {
		measured {
			tblDeselectRow(
				at: indexPath,
				animated: animated
			)
		}
	}

	open func tblDeselectRow(
		at indexPath: IndexPath,
		animated: Bool
	) {
		super.deselectRow(
			at: indexPath,
			animated: animated
		)
	}
}

#endif
