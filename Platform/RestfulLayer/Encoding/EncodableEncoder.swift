//
//  AnyEncodableEncoding.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

private struct EncodableProxy: Encodable {

    private let encodable: Encodable

    init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}


struct EncodableEncoder: ParameterEncoding {
    
    private let proxy: EncodableProxy
    private let encoder: JSONEncoder
    
    init(_ encodable: Encodable) {
        self.proxy = EncodableProxy(encodable)
        self.encoder = JSONEncoder()
    }
    
    func encode(_ urlRequest: URLRequest, with parameters: Parameters? = nil) throws -> URLRequest {
        var urlRequest = urlRequest
        do {
            let encodable = EncodableProxy(proxy)
            urlRequest.httpBody = try encoder.encode(encodable)

            let contentTypeHeaderName = "Content-Type"
            if urlRequest.value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }

            return urlRequest
        } catch {
            throw RestfulLayer.Error.Encoding.parameterEncoding(error)
        }
    }
    
}
