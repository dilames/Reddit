//
//  RedditImageUseCase.swift
//  Domain
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import Combine

public protocol RedditPicturesUseCase {
    func pictureDataPublisher(for url: URL) -> AnyPublisher<Data, Swift.Error>
}

public protocol HasRedditPicturesUseCase {
    var redditPictures: RedditPicturesUseCase { get }
}

