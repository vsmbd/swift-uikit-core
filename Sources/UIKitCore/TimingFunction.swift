//
//  TimingFunction.swift
//  UIKitCore
//
//  Created by vsmbd on 12/02/26.
//

import Foundation
import UIKit

// MARK: - TimingFunction

@MainActor
public final class TimingFunction {
	// MARK: + Private scope

	@MainActor
	private let probe = UIView(
		frame: CGRect(
			x: -10000,
			y: -10000,
			width: 1,
			height: 1
		)
	)

	private let animator: UIViewPropertyAnimator

	// MARK: + Default scope

	// Optional: pre-warm to ensure first read has presentation state ready.
	@MainActor
	func setup() {
		_ = eased(0)
	}

	@MainActor
	deinit {
		if animator.state != .inactive {
			// Stop without finishing
			animator.stopAnimation(true)
			animator.finishAnimation(at: .current)
		}
		probe.removeFromSuperview()
	}

	// MARK: + Public scope

	@MainActor
	public static func linear(_ duration: TimeInterval) -> Self {
		.init(
			.linear,
			duration: duration
		)
	}

	@MainActor
	public static func easeInEaseOut(_ duration: TimeInterval) -> Self {
		.init(
			.easeInEaseOut,
			duration: duration
		)
	}

	@MainActor
	public static func easeIn(_ duration: TimeInterval) -> Self {
		.init(
			.easeIn,
			duration: duration
		)
	}

	@MainActor
	public static func easeOut(_ duration: TimeInterval) -> Self {
		.init(
			.easeOut,
			duration: duration
		)
	}

	public let duration: TimeInterval

	@MainActor
	public init(
		function: CAMediaTimingFunction,
		duration: TimeInterval
	) {
		self.probe.isHidden = true
		self.probe.alpha = 0
		self.probe.isAccessibilityElement = false
		self.probe.accessibilityElementsHidden = true

		// Put the probe in a real window (offscreen)
		UIWindow.keyWindow?.addSubview(probe)

		self.duration = duration

		// Build cubic timing parameters from the CA function's control points
		let (p1, p2) = function.cubicControlPoints
		let params = UICubicTimingParameters(
			controlPoint1: p1,
			controlPoint2: p2
		)

		animator = UIViewPropertyAnimator(
			duration: duration,
			timingParameters: params
		)

		// Scrub along the timing curve
		animator.scrubsLinearly = false

		// Final value to reach
		animator.addAnimations { [weak probe] in
			probe?.alpha = 1
		}

		// Primes fractionComplete scrubbing
		animator.startAnimation()
		animator.pauseAnimation()
	}

	@MainActor
	public convenience init(
		_ name: CAMediaTimingFunctionName,
		duration: TimeInterval
	) {
		self.init(
			function: CAMediaTimingFunction(name: name),
			duration: duration
		)
	}

	@MainActor
	public func eased(_ linear: CGFloat) -> CGFloat {
		let clampedLinear: CGFloat = max(0, min(linear, 1))
		animator.fractionComplete = clampedLinear

		guard let presentation = probe.layer.presentation() else {
			return clampedLinear
		}

		return CGFloat(presentation.opacity)
	}
}

fileprivate extension CAMediaTimingFunction {
	var cubicControlPoints: (CGPoint, CGPoint) {
		var p1 = [Float](repeating: 0, count: 2)
		var p2 = [Float](repeating: 0, count: 2)

		getControlPoint(at: 1, values: &p1)
		getControlPoint(at: 2, values: &p2)

		return (
			CGPoint(x: CGFloat(p1[0]), y: CGFloat(p1[1])),
			CGPoint(x: CGFloat(p2[0]), y: CGFloat(p2[1]))
		)
	}
}
