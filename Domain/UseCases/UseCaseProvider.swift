//
//  UseCaseProvider.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

public typealias UseCases =
    HasRedditEndpointUseCase
    & HasRedditPicturesUseCase
    & HasRedditChronoUseCase

public protocol UseCaseProvider: UseCases {}
