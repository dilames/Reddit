//
//  FeedDetailsViewModel.swift
//  Reddit
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import Platform
import Domain


struct FeedDetailsViewModel: ViewModel {
    
    typealias UseCases = HasRedditPicturesUseCase
    
    private let url: URL
    private let useCases: UseCases
    
    init(useCases: UseCases, url: URL) {
        self.useCases = useCases
        self.url = url
    }
    
}
