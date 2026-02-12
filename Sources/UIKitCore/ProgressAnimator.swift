//
//  ProgressAnimator.swift
//  UIKitCore
//
//  Created by vsmbd on 12/02/26.
//

import Foundation
import UIKit

// MARK: - ProgressAnimator

public final class ProgressAnimator {
	// MARK: + Private scope

	private var progressBlock: ProgressBlock?
	private var completionBlock: CompletionBlock?

	private var displayLink: CADisplayLink?
	private var duration: TimeInterval = 0
	private var startTime: CFTimeInterval = 0

	@MainActor
	@objc private func updateProgression(_ link: CADisplayLink) {
		guard duration > 0 else {
			stopDisplayLink()
			return
		}

		if startTime == 0 {
			startTime = link.targetTimestamp
		}

		let elapsed: CGFloat = link.targetTimestamp - startTime
		let linearProgress: CGFloat = elapsed / duration
		var easedProgress = timingFunction.eased(linearProgress)

		if easedProgress >= 0.999 || linearProgress >= 1.05 {
			easedProgress = 1
		}

		progress = easedProgress
		progressBlock?(easedProgress)

		if easedProgress == 1 {
			stopDisplayLink()
			progressBlock = nil
			completionBlock?()
			completionBlock = nil
		}
	}

	@MainActor
	private func startDisplayLink() {
		stopDisplayLink()

		timingFunction.setup()

		displayLink = CADisplayLink(
			target: self,
			selector: #selector(updateProgression)
		)

		displayLink?.add(
			to: .main,
			forMode: .common
		)
	}

	@MainActor
	private func stopDisplayLink() {
		displayLink?.invalidate()
		displayLink = nil
		startTime = 0
	}

	// MARK: + Public scope

	public typealias ProgressBlock = (CGFloat) -> Void
	public typealias CompletionBlock = () -> Void

	@MainActor
	public private(set) lazy var timingFunction: TimingFunction = {
		.linear(duration)
	}()

	@MainActor
	public private(set) var progress: CGFloat = .zero

	@MainActor
	public var isAnimating: Bool {
		displayLink != nil
	}

	public init() {
		//
	}

	@MainActor
	public func start(
		timingFunction: TimingFunction,
		progress: @escaping ProgressBlock,
		completion: CompletionBlock? = nil
	) {
		guard self.progressBlock == nil else { return }

		self.timingFunction = timingFunction
		self.duration = timingFunction.duration
		self.progressBlock = progress
		self.completionBlock = completion

		startDisplayLink()
	}

	@MainActor
	public func stop() {
		stopDisplayLink()
		progressBlock = nil
		completionBlock = nil
	}
}
