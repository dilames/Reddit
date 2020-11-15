//
//  FeedCollectionCellViewModel.swift
//  Reddit
//
//  Created by Andrew Chersky on 14.11.2020.
//

import Foundation
import Platform

struct FeedCollectionCellViewModel: ViewModel {
    
    let title: String
    let author: String
    let date: Date
    let imageURL: URL?
    let commentsNumber: Int
    
}
