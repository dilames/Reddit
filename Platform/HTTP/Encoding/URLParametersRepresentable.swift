//
//  URLParametersRepresentable.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

public protocol URLParametersRepresentable: Encodable {
    var urlParameters: Parameters? { get }
}

public extension URLParametersRepresentable {
    
    var urlParameters: Parameters? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return jsonObject.flatMap { $0 as? [String: Any] }
    }
    
}
