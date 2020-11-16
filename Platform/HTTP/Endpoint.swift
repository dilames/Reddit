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
        self.decoder = .secondsSince1970
    }
    
    func perform<D: Decodable>(_ httpEndpoint: HTTPEndpoint) -> AnyPublisher<D, Swift.Error> {
        return httpSession
            .httpResponsePublisher(httpEndpoint)
            .mapError { Error.session($0) }
            .flatMap { [unowned self] (httpResponse) in
                Just(httpResponse)
                    .map(\.data)
                    .decode(type: D.self, decoder: decoder)
                    .mapError { Error.objectMapping($0, httpResponse) }
            }
            .eraseToAnyPublisher()
    }
    
}
