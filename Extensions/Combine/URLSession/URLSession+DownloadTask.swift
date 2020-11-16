//
//  URLSession+DownloadTask.swift
//  Extensions
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import Combine

public extension URLSession {
    
    func downloadTaskPublisher(for urlRequest: URLRequest) -> URLSession.DownloadTaskPublisher {
        return DownloadTaskPublisher(urlSession: self, urlRequest: urlRequest)
    }
    
    
    struct DownloadTaskPublisher: Publisher {
        
        public typealias Output = (data: Data, fileUrl: URL, response: URLResponse)
        public typealias Failure = URLError
        
        public let urlSession: URLSession
        public let urlRequest: URLRequest
        
        init(urlSession: URLSession, urlRequest: URLRequest) {
            self.urlSession = urlSession
            self.urlRequest = urlRequest
        }
        
        public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = DownloadTaskSubscription(subscriber: subscriber, urlSession: urlSession, urlRequest: urlRequest)
            subscriber.receive(subscription: subscription)
        }
        
    }
    
}

extension URLSession {
    
    final class DownloadTaskSubscription<SubscriberType: Subscriber>: Subscription where
        SubscriberType.Input == DownloadTaskPublisher.Output,
        SubscriberType.Failure == URLError {
        
        private var subscriber: SubscriberType?
        private weak var session: URLSession!
        private var request: URLRequest!
        private var task: URLSessionDownloadTask?
        private var fileManager: FileManager
        
        init(subscriber: SubscriberType, urlSession: URLSession, urlRequest: URLRequest, fileManager: FileManager = .default) {
            self.fileManager = fileManager
            self.subscriber = subscriber
            self.session = urlSession
            self.request = urlRequest
        }
        
        func request(_ demand: Subscribers.Demand) {
            guard demand > 0 else { return }
            task = session.downloadTask(with: request) { [weak self] (url, urlResponse, error) in
                
                if let error = error as? URLError {
                    self?.subscriber?.receive(completion: .failure(error))
                    return
                }
                
                guard let urlResponse = urlResponse else {
                    self?.subscriber?.receive(completion: .failure(URLError(.badServerResponse)))
                    return
                }
                
                guard let url = url else {
                    self?.subscriber?.receive(completion: .failure(URLError(.badURL)))
                    return
                }
                
                guard
                    let fileManager = self?.fileManager,
                    let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
                else {
                    self?.subscriber?.receive(completion: .failure(URLError(.cannotCreateFile)))
                    return
                }
                
                let fileUrl = cachesDirectory.appendingPathComponent((UUID().uuidString))
                
                do {
                    try FileManager.default.moveItem(atPath: url.path, toPath: fileUrl.path)
                    _ = self?.subscriber?.receive((data: try Data(contentsOf: fileUrl), fileUrl: fileUrl, response: urlResponse))
                    self?.subscriber?.receive(completion: .finished)
                }
                catch {
                    self?.subscriber?.receive(completion: .failure(URLError(.cannotCreateFile)))
                }
                
            }
            self.task?.resume()
        }
        
        func cancel() {
            self.task?.cancel()
        }
        
    }
    
}
