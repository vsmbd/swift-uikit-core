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

	// MARK: ++ Init

	public convenience init() {
		self.init(
			frame: .zero,
			style: .plain
		)
	}

	public override init(
		frame: CGRect,
		style: UITableView.Style
	) {
		self.identifier = Self.nextID
		super.init(
			frame: frame,
			style: style
		)
		translatesAutoresizingMaskIntoConstraints = false
		measured {
			initialize()
		}
	}

	public required init?(coder: NSCoder) {
		fatalError(
			"CheckpointedTableView must be instantiated with init() or init(frame:style:)"
		)
	}

	open func initialize() {
		//
	}

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
