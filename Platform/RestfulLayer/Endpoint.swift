//
//  Endpoint.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

#if canImport(UIKit)
import UIKit.UIImage
public typealias ImageType = UIImage
#elseif canImport(AppKit)
import AppKit.NSImage
public typealias ImageType = NSImage
#endif


class Endpoint<Target: EndpointType> {
    
    typealias DecodingResult<T> = Result<T, RestfulLayer.Error>
    typealias Completion<T> = (Result<T, RestfulLayer.Error>) -> Void
    
    private let restfulLayer: RestfulLayer
    private let jsonDecoder: JSONDecoder
    
    init(restfulLayer: RestfulLayer) {
        self.restfulLayer = restfulLayer
        self.jsonDecoder = .iso8601
    }
    
}

// MARK: TargetType Support
internal extension Endpoint {
    
    func fetch<D: Codable & Equatable>(_ target: Target,
                                       completion: @escaping Completion<D>) -> Cancellable {
        restfulLayer.dataRequest(target) { [weak self] (result) in
            
            switch result {
            case .success(let data):
                do {
                    guard let decoded = try self?.jsonDecoder.decode(D.self, from: data) else { return }
                    completion(.success(decoded))
                } catch {
                    if let error = try? self?.jsonDecoder.decode(Target.Error.self, from: data) {
                        completion(.failure(.underlying(error)))
                        return
                    }
                    completion(.failure(.objectMapping(error)))
                }
            case .failure(let error):
                completion(.failure(.underlying(error)))
            }
        }
        
    }
    
    func fetchImage(_ target: Target,
               completion: @escaping Completion<ImageType>) -> Cancellable {
        restfulLayer.dataRequest(target) {
            switch $0 {
            case .success(let data):
                guard let image = ImageType(data: data) else {
                    completion(.failure(.imageMapping))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.underlying(error)))
            }
        }
        
        return CancellableToken { }
    }
}
