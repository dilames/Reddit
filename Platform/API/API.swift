//
//  API.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

public enum API: HTTPEndpointDescribable {
    
    case top(time: Time, after: String?, before: String?, count: Int, limit: Int, show: Show, srDetail: Bool)
    
    public var path: String {
        switch self {
        case .top(let time, let after, let before, let count, let limit, let show, let srDetail):
            return "top"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .top: return .get
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
