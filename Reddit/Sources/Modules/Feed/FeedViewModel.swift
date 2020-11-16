//
//  FeedViewModel.swift
//  Reddit
//
//  Created by Andrew Chersky on 12.11.2020.
//

import Combine
import Foundation
import Platform
import Domain

struct FeedViewModel: ViewModel {
    
    typealias UseCases = HasRedditEndpointUseCase & HasRedditChronoUseCase
    
    struct Output {
        let posts: AnyPublisher<[Child], Never>
    }
    
    func transform(_ input: Void) -> Output {
        let posts = useCases.redditEndpoint.fetchTopRedditPosts()
            .map { $0.data.children.compactMap { $0.data } }
            .catch { error in
                return Empty<[Child], Never>()
            }
            .eraseToAnyPublisher()
        return Output(posts: posts)
    }
    
    let useCases: UseCases
    
    init(useCases: UseCases) {
        self.useCases = useCases
    }

}
