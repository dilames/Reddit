//
//  Task.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

/// Represents an HTTP task.
public enum Task {

    /// A request with no additional data.
    case requestPlain

    /// A request body set with `Encodable` type
    case requestJSONEncodable(Encodable)

    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
    
}
