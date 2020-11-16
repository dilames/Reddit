//
//  RedditPicturesService.swift
//  Platform
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import Domain
import Combine

private protocol DataCachable: class {
    func data(for url: URL) -> Data?
    func cache(data: Data?, for url: URL)
    func uncache(for url: URL)
}

private final class DataCache: DataCachable {
    
    private lazy var cache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 1024
        return cache
    }()
    
    private let lock = NSLock()
    
    func cache(data: Data?, for url: URL) {
        guard let data = data else { return uncache(for: url) }
        
        lock.lock()
        defer { lock.unlock() }
        cache.setObject(data as AnyObject, forKey: url as AnyObject)
    }
    
    func uncache(for url: URL) {
        lock.lock()
        defer { lock.unlock() }
        cache.removeObject(forKey: url as AnyObject)
    }
    
    func data(for url: URL) -> Data? {
        lock.lock()
        defer { lock.unlock() }
        guard let data = cache.object(forKey: url as AnyObject) as? Data else {
            return nil
        }
        return data
    }
    
}

final class RedditPicturesService: RedditPicturesUseCase {
    
    private let httpSession: HTTPSession
    private let dataCache: DataCache
    
    public init(httpSession: HTTPSession) {
        self.httpSession = httpSession
        self.dataCache = DataCache()
    }
    
    func pictureDataPublisher(for url: URL) -> AnyPublisher<Data, Swift.Error> {
        if let data = dataCache.data(for: url) {
            return Just(data)
                .setFailureType(to: Swift.Error.self)
                .eraseToAnyPublisher()
        }
        return httpSession
            .imageDataPublisher(url)
            .handleEvents(receiveOutput: { [unowned self] in dataCache.cache(data: $0, for: url) })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .mapError { $0 as Swift.Error }
            .eraseToAnyPublisher()
    }
    
}
