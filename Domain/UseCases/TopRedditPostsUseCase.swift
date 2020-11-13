//
//  TopRedditPostsUseCase.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Combine

public protocol TopRedditPostsUseCase {
    func fetchTopRedditPosts() -> AnyPublisher<[String], Error>
}

public protocol HasTopRedditPostsUseCase {
    var topRedditPostsUseCase: TopRedditPostsUseCase { get }
}
