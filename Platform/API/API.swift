//
//  API.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

public enum API: HTTPEndpointDescribable {
    
    case top(t: String, after: String, before: String, count: String, limit: String, show: String, sr_detail: String)
    
    public var path: String {
        return "/top/www.reddit.com"
    }
    
    public var method: HTTPMethod {
        return .get
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
