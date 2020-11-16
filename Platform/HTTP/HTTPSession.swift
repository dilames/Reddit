//
//  HTTPSession.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation
import Combine
import Extensions

final public class HTTPSession {
    
    public enum Error: Swift.Error {
        case urlError(URLError)
        case missingUrl
    }
    
    public typealias Response = (data: Data, response: URLResponse)
    
    private let urlSession: URLSession
    private let baseURL: URL
    
    public init(session: URLSession = URLSession.shared, baseURL: URL) {
        self.urlSession = session
        self.baseURL = baseURL
    }
    
}

// MARK: Public - Requests
public extension HTTPSession {
    
    func httpResponsePublisher<T: HTTPEndpointDescribable>(_ endpoint: T) -> AnyPublisher<Response, Error> {
        return urlRequest(for: endpoint)
            .flatMap { [unowned self] in
                urlSession.dataTaskPublisher(for: $0)
                    .mapError { Error.urlError($0) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func httpDataPublisher<T: HTTPEndpointDescribable>(_ endpoint: T) -> AnyPublisher<Data, Error> {
        return urlRequest(for: endpoint)
            .flatMap { [unowned self] in
                urlSession.downloadTaskPublisher(for: $0)
                    .map { $0.data }
                    .mapError { Error.urlError($0) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
}

// MARK: Private
private extension HTTPSession {
    
    func urlRequest<T: HTTPEndpointDescribable>(for endpoint: T) -> AnyPublisher<URLRequest, Error> {
        
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(endpoint.path))
        
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.defaultHeaders + endpoint.headers
        
        return CurrentValueSubject(urlRequest).eraseToAnyPublisher()
    }
    
    
}
