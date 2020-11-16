//
//  HTTPDescribable.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import struct Foundation.URL

public protocol HTTPEndpointDescribable {
    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    /// The headers to be used in the specific request.
    var headers: [String: String] { get }
    /// The headers to be used in all requests.
    var defaultHeaders: [String: String] { get }
}

public extension HTTPEndpointDescribable {
    var baseURL: URL? { return nil }
}
