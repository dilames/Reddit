//
//  Platform.swift
//  Platform
//
//  Created by Andrew Chersky on 15.11.2020.
//

import Foundation
import Domain

public class Platform: UseCaseProvider {
    
    public let redditEndpoint: RedditEndpointUseCase
    public let redditPictures: RedditPicturesUseCase
    public let redditChrono: RedditChronoUseCase
    
    private let httpSession: HTTPSession
    private let environment: Environment
    
    public init(environment: Environment) {
        self.environment = environment
        self.httpSession = HTTPSession(baseURL: environment.baseURL)
        self.redditEndpoint = RedditEndpoint(httpSession: httpSession)
        self.redditPictures = RedditPicturesService(httpSession: httpSession)
        self.redditChrono = ChronoService()
    }

}
