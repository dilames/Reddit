//
//  Error.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

extension RestfulLayer {
    
    enum Error: Swift.Error {
        
        enum Encoding: Swift.Error {
            case parameterEncoding(Swift.Error)
            case missingUrl
        }
        
        case underlying(Swift.Error)
        case objectMapping(Swift.Error)
        case encoding(Encoding)
        case imageMapping
        
    }
    
}
