//
//  HTTPRequestBuilder.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation

public protocol HTTPRequestBuilder: Sendable {
    
    func buildRequest(method: HTTPMethod, source: HTTPSource, query: [String: String]?, headers: [String: String]?, body: HTTPBody?) async throws -> URLRequest
}

public extension HTTPRequestBuilder {
    
    func buildRequest(method: HTTPMethod, source: HTTPSource, query: [String: String]? = nil, headers: [String: String]? = nil, body: HTTPBody? = nil) async throws -> URLRequest {
        return try await buildRequest(method: method, source: source, query: query, headers: headers, body: body)
    }
}
