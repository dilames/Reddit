//
//  API.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

public enum API: HTTPEndpointDescribable {
    
    case top(descriptor: API.Listing)
    
    public var path: String {
        switch self {
        case .top:
            return "top"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .top: return .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .top(let descriptor):
            return .requestParameters(parameters: descriptor.urlParameters,
                                      encoding: URLEncoding())
        }
    }
    
    public var headers: [String : String] {
        return [:]
    }
    
    public var defaultHeaders: [String : String] {
        let timeInterval = Date().timeIntervalSince1970 * 1000.0
        return [
            "User-Agent": "Reddit Client 1.0.0",
            "X-Amzn-Trace-Id": "Root=1-\(Int(timeInterval.rounded()))-\(UUID().uuidString)"
        ]
    }
    
}
