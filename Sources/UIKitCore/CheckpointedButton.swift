//
//  CheckpointedButton.swift
//  UIKitCore
//
//  Created by vsmbd on 10/02/26.
//

#if os(iOS) || os(tvOS)

import SwiftCore
import UIKit

// MARK: - CheckpointedButton

/// Base `UIButton` for consistent identity and checkpointing.
/// Subclass and override the open `btn...` methods to customize behavior or add instrumentation (e.g. tap event sink).
open class CheckpointedButton: UIButton,
							   Entity {
	// MARK: + Public scope

	public let identifier: UInt64

	// MARK: ++ Init

	public init(type buttonType: UIButton.ButtonType = .system) {
		self.identifier = Self.nextID
		super.init(type: buttonType)
		measured {
			initialize()
		}
	}

	public override init(frame: CGRect) {
		fatalError("CheckpointedButton must be instantiated with init(type:)")
	}

	public required init?(coder: NSCoder) {
		fatalError("CheckpointedButton must be instantiated with init(type:)")
	}

	open func initialize() {
		//
	}
}

#endif
