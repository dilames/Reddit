//
//  ImageService.swift
//  Platform
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import Domain
import Combine

final class RedditPicturesService: RedditPicturesUseCase {
    
    private let httpSession: HTTPSession
    
    public init(httpSession: HTTPSession) {
        self.httpSession = httpSession
    }
    
    func pictureDataPublisher(for url: URL) -> AnyPublisher<Data, Swift.Error> {
        return CurrentValueSubject<Data, Swift.Error>(Data()).eraseToAnyPublisher()
    }
    
}
