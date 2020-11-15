//
//  Platform.swift
//  Platform
//
//  Created by Andrew Chersky on 15.11.2020.
//

import Foundation
import Domain

public class Platform: UseCaseProvider {
    
    public var redditEndpointUseCase: RedditEndpointUseCase
    
    private let httpSession: HTTPSession
    private let environment: Environment
    
    public init(environment: Environment) {
        self.environment = environment
        self.httpSession = HTTPSession(baseURL: environment.baseURL)
        self.redditEndpointUseCase = RedditEndpoint(httpSession: httpSession)
    }

}
