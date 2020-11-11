//
//  RestfulLayer.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

final class RestfulLayer {
    
    public typealias Completion<T> = (Swift.Result<T, Swift.Error>) -> Void
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
}

// MARK: Public - Requests
extension RestfulLayer {
    
    @discardableResult
    func dataRequest<T: EndpointType>(_ target: T,
                                      completion: @escaping Completion<Foundation.Data>) -> Cancellable {
        var dataTask: URLSessionDataTask?
        
        do {
            dataTask = try self.dataTask(target, completion: { (data, response, error) in
                if let data = data { completion(.success(data)) }
                if let error = error { completion(.failure(error)) }
            })
        } catch {
            completion(.failure(error))
        }
        
        dataTask?.resume()
        return CancellableToken { dataTask?.cancel() }
    }
    
}


// MARK: Private - Encoding & DataTask
private extension RestfulLayer {
    
    func urlRequest<T: EndpointType>(for target: T) throws -> URLRequest {
        
        let timeInterval = Date().timeIntervalSince1970 * 1000.0
        
        let headers = [
            "User-Agent": "Reddit Client 1.0.0",
            "X-Amzn-Trace-Id": "Root=1-\(Int(timeInterval.rounded()))-\(UUID().uuidString)"
        ]
        
        var urlRequest = URLRequest(url: target.baseURL.appendingPathComponent(target.path))
        
        urlRequest.httpMethod = target.method.rawValue
        urlRequest.allHTTPHeaderFields = headers + target.headers
        
        return urlRequest
    }
    
    func encoded(_ urlRequest: URLRequest, with task: Task) throws -> URLRequest {
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
    
    func dataTask<T: EndpointType>(_ target: T,
                                   completion: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) throws -> URLSessionDataTask {
        let encodedUrlRequest = try encoded(urlRequest(for: target), with: target.task)
        return session.dataTask(
            with: encodedUrlRequest,
            completionHandler: completion
        )
    }
    
}
