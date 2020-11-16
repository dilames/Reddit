//
//  JSONDecoder+secondsSince1970.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

public extension JSONDecoder {
    
    static let secondsSince1970: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
}
