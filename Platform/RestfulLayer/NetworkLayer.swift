//
//  NetworkLayer.swift
//  Abstract
//
//  Created by Andrew Chersky on 21.05.2020.
//

import Foundation

internal class NetworkLayer {
    
    public typealias RequestResult = Result<Foundation.Data, Error>
    public typealias Completion<T> = (Swift.Result<T, Error>) -> Void
    
    private let session = URLSession.shared
    private let token: String
    private let routes: Client.Routes
    
    internal init(routes: Client.Routes, token: String) {
        self.routes = routes
        self.token = token
    }
    
    #warning("TODO: Send additional required headers")
    private func urlRequest<T: AbstractTargetType>(for target: T) throws -> URLRequest {
        guard !token.isEmpty else {
            throw AbstractError.authorization(.missingToken)
        }
        
        let timeInterval = Date().timeIntervalSince1970 * 1000.0
        
        let headers = [
            "User-Agent": "Swift SDK 1.0.0",
            "X-Amzn-Trace-Id": "Root=1-\(Int(timeInterval.rounded()))-\(UUID().uuidString)"
        ]
        
        var urlRequest = URLRequest(url: routes.route(for: target))
        urlRequest.httpMethod = target.method.rawValue
        urlRequest.allHTTPHeaderFields = headers + target.headers
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    private func encoded(_ urlRequest: URLRequest, with task: Task) throws -> URLRequest {
        switch task {
        case .requestParameters(let parameters, let encoder):
            return try encoder.encode(urlRequest, with: parameters)
        case .requestJSONEncodable(let encodable):
            let encoder = EncodableEncoder(encodable)
            return try encoder.encode(urlRequest)
        case .requestPlain:
            return urlRequest
        }
    }
    
    @discardableResult
    func dataRequest<T: AbstractTargetType>(_ target: T,
                                            completion: @escaping Completion<Foundation.Data>) -> Cancellable {
        var dataTask: URLSessionDataTask?
        
        do {
            dataTask = session.dataTask(
                with: try encoded(urlRequest(for: target), with: target.task),
                completionHandler: { (data, response, error) in
                    if let data = data { completion(.success(data)) }
                    if let error = error { completion(.failure(error)) }
            })
        } catch {
            completion(.failure(error))
        }
        
        dataTask?.resume()
        return CancellableToken { dataTask?.cancel() }
    }
    
    @discardableResult
    func responseRequest<T: AbstractTargetType>(_ target: T,
                                        completion: @escaping Completion<URLResponse>) -> Cancellable {
        var dataTask: URLSessionDataTask?
        
        do {
            dataTask = session.dataTask(
                with: try encoded(urlRequest(for: target), with: target.task),
                completionHandler: { (data, response, error) in
                    if let response = response { completion(.success(response)) }
                    if let error = error { completion(.failure(error)) }
            })
        } catch {
            completion(.failure(error))
        }
        
        dataTask?.resume()
        return CancellableToken { dataTask?.cancel() }
        
    }
    
}
