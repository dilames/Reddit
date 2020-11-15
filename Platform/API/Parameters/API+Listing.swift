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
        
    }
    
}

// MARK: - Codable Protocol Support
extension API.Listing {
    
    private enum CodingKeys: String, CodingKey {
        case direction = ""
        case time = "t"
        case show
        case count
        case limit
        case subredditDetails = "sr_details"
    }
    
}
