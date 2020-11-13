//
//  API+Show.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

extension API {
    
    public struct Show: RawRepresentable, Equatable, Hashable, Encodable {
        
        static let all = Show(rawValue: "all")
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
    }
    
}
