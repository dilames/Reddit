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
    
    func fetchTopRedditPosts() -> AnyPublisher<[String], Swift.Error> {
        let descriptor = API.Listing(time: .all, direction: nil, count: 0, limit: 100, show: .all, subredditDetails: true)
        return perform(.top(descriptor))
    }
    
}
