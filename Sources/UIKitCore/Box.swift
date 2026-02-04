//
//  Box.swift
//  UIKitCore
//
//  Created by vsmbd on 04/02/26.
//

// MARK: - Box

/// Type-erasing wrapper that conforms to `@unchecked Sendable` for use in `@Sendable` closures.
/// Use to capture non-Sendable values when passing a closure to an API that requires `@Sendable`.
final class Box<T>: @unchecked Sendable {
	let value: T
	init(_ value: T) { self.value = value }
}
