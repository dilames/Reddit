//
//  JSONDecoder+iso8601.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

public extension JSONDecoder {
    
    static let iso8601: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601)
        return decoder
    }()
    
}
