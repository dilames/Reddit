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
    
    typealias UseCases = HasRedditChronoUseCase
    
    let title: String
    let author: String
    let date: Date
    let imageURL: URL?
    let commentsNumber: Int
    
    let useCases: UseCases
    
}
