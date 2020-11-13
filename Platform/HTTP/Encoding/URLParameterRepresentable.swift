//
//  URLParameterRepresentable.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

public protocol URLParameterRepresentable: RawRepresentable, Encodable where RawValue: Encodable {
    var rawValue: RawValue { get }
    var codingKey: CodingKey { get }
}

public extension URLParameterRepresentable {
    init?(rawValue: Self.RawValue) { return nil }
}

public extension Array where Element: URLParameterRepresentable & Encodable {
    var urlParameters: [String: Element.RawValue]? {
        return reduce(into: [:]) { $0[$1.codingKey.stringValue] = $1.rawValue }
    }
}
