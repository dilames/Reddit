//
//  ParameterEncoding.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoding {
    func encode(urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
}

public struct URLEncoding: ParameterEncoding {
    
    private let httpHeaderField: String = "Content-Type"
    private let urlEncodedHeaderValue: String = "application/x-www-form-urlencoded; charset=utf-8"
    
    public func encode(urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        guard let parameters = parameters else { return urlRequest }
        guard let url = urlRequest.url else { throw HTTPSession.Error.missingUrl }
        
        var urlRequest = urlRequest
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(
                    name: $0.key,
                    value: "\($0)".addingPercentEncoding(withAllowedCharacters: .rfc3986QueryAllowed)
                )
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: httpHeaderField) == nil {
            urlRequest.setValue(urlEncodedHeaderValue, forHTTPHeaderField: httpHeaderField)
        }
        
        return urlRequest
    }
    
    public func encode(urlRequest: URLRequest, with urlParametersRepresentable: URLParametersRepresentable) throws -> URLRequest {
        return try encode(urlRequest: urlRequest, with: urlParametersRepresentable.urlParameters)
    }
    
}
