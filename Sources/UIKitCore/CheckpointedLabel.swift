//
//  CheckpointedLabel.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import SwiftCore
import UIKit

// MARK: - CheckpointedLabel

/// Base `UILabel` for consistent identity and checkpointing.
/// Subclass and override the open `lbl...` methods to customize behavior or add instrumentation.
open class CheckpointedLabel: UILabel,
							   Entity {
	// MARK: + Public scope

	public let identifier: UInt64

	// MARK: ++ Init

	public init() {
		self.identifier = Self.nextID
		super.init(frame: .zero)
		measured {
			initialize()
		}
	}

	public override init(frame: CGRect) {
		fatalError("CheckpointedLabel must be instantiated with init()")
	}

	public required init?(coder: NSCoder) {
		fatalError("CheckpointedLabel must be instantiated with init()")
	}

	open func initialize() {
		//
	}
}

#endif
