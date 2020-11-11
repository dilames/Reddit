//
//  Dictionary+Merging.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

internal extension Dictionary {
    var jsonData: Foundation.Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}

internal extension Dictionary {
    
    @discardableResult
    static func +(lhs: Self, rhs: Self?) -> Self {
        return lhs.merging(rhs ?? [:]) { _ = $1; return $0; }
    }
    
    @discardableResult
    static func +=(lhs: inout Self, rhs: Self?) -> Self {
        lhs = lhs + rhs
        return lhs
    }
}
