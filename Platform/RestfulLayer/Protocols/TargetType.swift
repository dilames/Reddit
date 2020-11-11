//
//  TargetType.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import protocol Foundation.LocalizedError

import struct Foundation.Data
import struct Foundation.URL


internal protocol EndpointType {
    /// Assosiated enum of possible Errors
    associatedtype Error: LocalizedError & Decodable
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    /// The type of HTTP task to be performed.
    var task: Task { get }
    /// The headers to be used in the request.
    var headers: [String: String]? { get }
}

internal extension EndpointType {
    var baseURL: URL { return URL(fileURLWithPath: "") }
}
