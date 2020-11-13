//
//  HTTPDescribable.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import struct Foundation.URL

public protocol HTTPEndpointDescribable {
    var path: String { get }
    var method: HTTPMethod { get }
//    var task: Task { get }
    /// The headers to be used in the specific request.
    var headers: [String: String] { get }
    /// The headers to be used in all requests.
    var defaultHeaders: [String: String] { get }
}
