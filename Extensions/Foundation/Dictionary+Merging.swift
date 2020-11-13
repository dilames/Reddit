//
//  Dictionary+Merging.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

public extension Dictionary {
    
    @discardableResult
    static func +(lhs: Self, rhs: Self) -> Self {
        return lhs.merging(rhs) { _ = $1; return $0; }
    }
    
}
