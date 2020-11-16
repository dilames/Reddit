//
//  ChronoUseCase.swift
//  Domain
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import Combine

public protocol RedditChronoUseCase {
    func dateComponentsPublisher(from sourceDate: Date, interval: TimeInterval) -> AnyPublisher<String?, Never>
}

public protocol HasRedditChronoUseCase {
    var redditChrono: RedditChronoUseCase { get }
}
