//
//  FeedDetailsViewModel.swift
//  Reddit
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import Platform
import Domain
import Combine
import UIKit

struct FeedDetailsViewModel: ViewModel {
    
    typealias UseCases = HasRedditPicturesUseCase
    
    struct Output {
        let imageData: AnyPublisher<Data, Never>
    }
    
    private let url: URL
    private let useCases: UseCases
    
    init(useCases: UseCases, url: URL) {
        self.useCases = useCases
        self.url = url
    }
    
    func transform(_ input: ()) -> Output {
        let imageData = useCases.redditPictures
            .pictureDataPublisher(for: url)
            .catch { _ in Empty<Data, Never>() }
            .eraseToAnyPublisher()
        return Output(imageData: imageData)
    }
    
}
