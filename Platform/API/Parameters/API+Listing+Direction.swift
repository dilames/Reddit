//
//  API+Listing+Direction.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

extension API.Listing {
    
    enum Direction: Encodable, Hashable {
        case after(String)
        case before(String)
    }
    
}

// MARK: - Codable Protocol Support
extension API.Listing.Direction {
    
    private enum CodingKeys: CodingKey {
        case after
        case before
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .after(let value): try container.encode(value, forKey: .after)
        case .before(let value): try container.encode(value, forKey: .before)
        }
    }
    
}
