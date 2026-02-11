//
//  CheckpointedCollectionView.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import SwiftCore
import UIKit

// MARK: - CheckpointedCollectionView

/// Base `UICollectionView` for consistent identity and checkpointing.
/// Subclass and override the open `cv...` methods to customize behavior or add instrumentation.
open class CheckpointedCollectionView: UICollectionView,
									   Entity {
	// MARK: + Public scope

	public let identifier: UInt64

	/// Logical id for this collection view (e.g. from `CheckpointedViewController.collectionView(id:)`). Immutable after init.
	public let viewId: String

	// MARK: ++ Init

	public convenience init(viewId: String) {
		self.init(viewId: viewId, frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	}

	public init(
		viewId: String,
		frame: CGRect,
		collectionViewLayout layout: UICollectionViewLayout
	) {
		self.viewId = viewId
		self.identifier = Self.nextID
		super.init(frame: frame, collectionViewLayout: layout)
		translatesAutoresizingMaskIntoConstraints = false
		measured {
			initialize()
		}
	}

	public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		fatalError("CheckpointedCollectionView must be instantiated with init(viewId:) or init(viewId:frame:collectionViewLayout:)")
	}

	public required init?(coder: NSCoder) {
		fatalError("CheckpointedCollectionView must be instantiated with init(viewId:) or init(viewId:frame:collectionViewLayout:)")
	}

	open func initialize() {
		//
	}

	// MARK: ++ Selection hooks (for Step 2 instrumentation)

	public override func selectItem(
		at indexPath: IndexPath?,
		animated: Bool,
		scrollPosition: UICollectionView.ScrollPosition
	) {
		measured {
			cvSelectItem(
				at: indexPath,
				animated: animated,
				scrollPosition: scrollPosition
			)
		}
	}

	open func cvSelectItem(
		at indexPath: IndexPath?,
		animated: Bool,
		scrollPosition: UICollectionView.ScrollPosition
	) {
		super.selectItem(
			at: indexPath,
			animated: animated,
			scrollPosition: scrollPosition
		)
	}

	public override func deselectItem(
		at indexPath: IndexPath,
		animated: Bool
	) {
		measured {
			cvDeselectItem(at: indexPath, animated: animated)
		}
	}

	open func cvDeselectItem(at indexPath: IndexPath, animated: Bool) {
		super.deselectItem(at: indexPath, animated: animated)
	}
}

#endif
