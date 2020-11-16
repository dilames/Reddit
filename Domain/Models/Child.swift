//
//  Child.swift
//  Domain
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation

public struct Child: Codable, Hashable {
    
    public let title: String
    public let author: String
    public let numComments: Int
    public let createdUtc: Date
    public let thumbnail: URL
    public let url: URL
    
    private enum CodingKeys: String, CodingKey {
        case title, author, thumbnail, url
        case createdUtc = "created_utc"
        case numComments = "num_comments"
    }
    
}
