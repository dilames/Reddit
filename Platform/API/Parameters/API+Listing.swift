//
//  API+Listing.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

extension API {
    
    public struct Listing: URLParametersRepresentable, Hashable {
        
        let time: API.Time
        let direction: API.Listing.Direction?
        let count: Int
        let limit: Int
        let show: API.Show
        let subredditDetails: Bool
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(time, forKey: .time)
            try container.encode(count, forKey: .count)
            try container.encode(limit, forKey: .limit)
            try container.encode(show, forKey: .show)
            try container.encode(subredditDetails, forKey: .subredditDetails)
            try direction?.encode(to: encoder)
        }
    }
    
}

// MARK: - Codable Protocol Support
extension API.Listing {
    
    private enum CodingKeys: String, CodingKey {
        case time = "t"
        case show
        case count
        case limit
        case subredditDetails = "sr_details"
    }
    
}
