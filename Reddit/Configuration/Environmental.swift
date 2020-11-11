//
//  Environmental.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

protocol Environmental {
    var baseURL: URL { get }
}

enum Environment: Environmental {
    
    case staging
    case production
    
    var baseURL: URL {
        return URL(string: "https://www.reddit.com/top")!
    }
    
}
