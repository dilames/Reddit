//
//  RedditEndpointUseCase.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Combine

public protocol RedditEndpointUseCase {
    func fetchFirstPage() -> AnyPublisher<[Child], Swift.Error>
    func fetchNextPage() -> AnyPublisher<[Child], Swift.Error>
}

public protocol HasRedditEndpointUseCase {
    var redditEndpoint: RedditEndpointUseCase { get }
}
