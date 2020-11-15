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
    
    func fetchTopRedditPosts() -> AnyPublisher<[String], Never> {
        return CurrentValueSubject([""]).eraseToAnyPublisher()
    }
    
}
