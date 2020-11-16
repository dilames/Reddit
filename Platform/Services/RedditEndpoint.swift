//
//  RedditEndpoint.swift
//  Platform
//
//  Created by Andrew Chersky on 15.11.2020.
//

import Foundation
import Domain
import Combine

final class RedditEndpoint: Endpoint<API>, RedditEndpointUseCase {
    
    private var tokenForNextPage: String = ""
    
    private func fetchPage(_ direction: API.Listing.Direction?) -> AnyPublisher<[Child], Swift.Error> {
        typealias DecodingType = Response<Meta<Response<Child>>>
        let descriptor = API.Listing(time: .all, direction: direction, count: 0, limit: 25, show: .all, subredditDetails: true)
        let response: AnyPublisher<DecodingType, Swift.Error> = perform(.top(descriptor))
        return response
            .handleEvents(receiveOutput: { self.tokenForNextPage = $0.data.after })
            .map { $0.data.children.map { $0.data } }
            .eraseToAnyPublisher()
    }
    
    func fetchFirstPage() -> AnyPublisher<[Child], Swift.Error> {
        return fetchPage(nil)
    }
    
    func fetchNextPage() -> AnyPublisher<[Child], Swift.Error> {
        return Just(tokenForNextPage)
            .filter { !$0.isEmpty }
            .flatMap(maxPublishers: .max(1), { [unowned self] in fetchPage(.after($0)) })
            .eraseToAnyPublisher()
    }
    
}
