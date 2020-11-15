//
//  Response.swift
//  Domain
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation

public struct Response<D: Codable>: Codable {
    
    public let kind: Kind
    public let data: D
    
    private enum CodingKeys: String, CodingKey {
        case kind, data
    }
    
}

public extension Response {
    
    enum Kind: String, Codable {
        case listing = "Listing"
        case link = "t3"
    }
    
}
