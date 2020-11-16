//
//  HTTPTask.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

public enum HTTPTask {
    case requestParameters(parameters: Parameters?, encoding: ParameterEncoding)
    case requestPlain
}
