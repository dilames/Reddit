//
//  Meta.swift
//  Domain
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation

public struct Meta<Child: Codable>: Codable {
    
    public let modhash: String
    public let dist: Int
    public let children: [Child]
    public let after: String
    public let before: String?

    enum CodingKeys: String, CodingKey {
        case modhash = "modhash"
        case dist = "dist"
        case children = "children"
        case after = "after"
        case before = "before"
    }
    
}
