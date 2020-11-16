//
//  RedditEndpointUseCase.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Combine

public protocol RedditEndpointUseCase {
    func fetchTopRedditPosts() -> AnyPublisher<Response<Meta<Response<Child>>>, Swift.Error>
}

public protocol HasRedditPostsUseCase {
    var redditEndpointUseCase: RedditEndpointUseCase { get }
}
