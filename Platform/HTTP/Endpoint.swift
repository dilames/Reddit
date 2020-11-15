//
//  Endpoint.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Combine
import Foundation

public class Endpoint<HTTPEndpoint: HTTPEndpointDescribable> {
    
    public enum Error: Swift.Error {
        case session(HTTPSession.Error)
        case objectMapping(Swift.Error, HTTPSession.Response)
    }
    
    private let httpSession: HTTPSession
    private let decoder: JSONDecoder
    
    public init(httpSession: HTTPSession) {
        self.httpSession = httpSession
        self.decoder = .iso8601
    }
    
    func perform<D: Decodable>(_ httpEndpoint: HTTPEndpoint) -> AnyPublisher<D, Swift.Error> {
        let httpSessionPublisher = httpSession
            .httpResponsePublisher(httpEndpoint)
            .mapError { Error.session($0) }
        return httpSessionPublisher
            .flatMap { [unowned self] (httpResponse) in
                httpSessionPublisher
                    .map(\.data)
                    .decode(type: D.self, decoder: decoder)
                    .mapError { Error.objectMapping($0, httpResponse) }
            }
            .mapError { $0 as Swift.Error }
            .eraseToAnyPublisher()
    }
}
