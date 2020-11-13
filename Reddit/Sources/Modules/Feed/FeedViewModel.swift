//
//  FeedViewModel.swift
//  Reddit
//
//  Created by Andrew Chersky on 12.11.2020.
//

import Combine
import Foundation

struct FeedViewModel: ViewModel {
    
    struct Output {
        let posts: AnyPublisher<[String], Never>
    }
    
    func transform(_ input: Void) -> Output {
        let postsPublisher = CurrentValueSubject<[String], Never>(["Hello", "I would like to try reload this CollectionView with Combine Subscriber"])
        return Output(posts: postsPublisher.eraseToAnyPublisher())
    }

}
