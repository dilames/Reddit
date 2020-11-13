//
//  API+Time.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

extension API {
    
    public struct Time: RawRepresentable, Equatable, Hashable, Encodable {
        
        static let hour = Time(rawValue: "hour")
        static let day = Time(rawValue: "day")
        static let week = Time(rawValue: "week")
        static let month = Time(rawValue: "month")
        static let year = Time(rawValue: "year")
        static let all = Time(rawValue: "all")
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
    }
    
}
