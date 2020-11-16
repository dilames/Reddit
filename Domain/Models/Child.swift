//
//  Child.swift
//  Domain
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation

public struct Child: Codable, Hashable {
    
    public let name: String
    public let title: String
    public let url: URL
    public let author: String
    public let numComments: Int?
    
}
