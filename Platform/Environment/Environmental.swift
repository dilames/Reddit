//
//  Environmental.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

public protocol Environmental {
    var baseURL: URL { get }
}

public enum Environment: Environmental {
    
    case staging
    case production
    
    public var baseURL: URL {
        return URL(string: "https://www.reddit.com/top")!
    }
    
}
