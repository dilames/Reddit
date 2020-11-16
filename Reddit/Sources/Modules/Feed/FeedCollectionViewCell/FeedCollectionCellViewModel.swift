//
//  FeedCollectionCellViewModel.swift
//  Reddit
//
//  Created by Andrew Chersky on 14.11.2020.
//

import Foundation
import Platform
import Combine
import Domain

struct FeedCollectionCellViewModel: ViewModel {
    
    typealias UseCases = HasRedditChronoUseCase & HasRedditPicturesUseCase
    
    struct Output {
        let pictureDataPublisher: AnyPublisher<Data, Swift.Error>
        let dateComponentsPublisher: AnyPublisher<String?, Never>
    }
    
    let useCases: UseCases
    
    let title: String
    let author: String
    let date: Date
    let imageURL: URL
    let commentsNumber: Int
    
    func transform(_ input: ()) -> Output {
        return Output(pictureDataPublisher: useCases.redditPictures.pictureDataPublisher(for: imageURL),
                      dateComponentsPublisher: useCases.redditChrono.dateComponentsPublisher(from: date, interval: 1))
    }
    
}
