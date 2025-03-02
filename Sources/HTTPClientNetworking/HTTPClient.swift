//
//  HTTPClient.swift
//
//
//  Created by Danijel Huis
//

import Foundation

public class HTTPClientDebugManager {
    public static var debugText: String = ""
    public static let identifier = Int.random(in: 0..<10000)
}

/// Networking abstraction.
public protocol HTTPClient: HTTPRequestBuilder, HTTPRequestService, Sendable {
    func authorizeRequest(_ request: URLRequest) async throws -> URLRequest
}

public final class DefaultHTTPClient: HTTPClient {
    
    private let requestBuilder: HTTPRequestBuilder
    private let requestInterceptors: [HTTPRequestInterceptor]
    private let requestService: HTTPRequestService
    
    public init(requestBuilder: HTTPRequestBuilder,
                requestInterceptors: [HTTPRequestInterceptor] = [],
                requestService: HTTPRequestService) {
        self.requestBuilder = requestBuilder
        self.requestInterceptors = requestInterceptors
        self.requestService = requestService
    }
    
    public func buildRequest(method: HTTPMethod,
                             source: HTTPSource,
                             query: [String : String]?,
                             headers: [String : String]?,
                             body: HTTPBody?) async throws -> URLRequest {
        try await requestBuilder.buildRequest(method: method, source: source, query: query, headers: headers, body: body)
    }
        
    public func authorizeRequest(_ request: URLRequest) async throws -> URLRequest {
        try await runInterceptors(request: request, types: [.authorizer])
    }
    
    public func performRequest(_ request: URLRequest) async throws -> Data {
        let request = try await runInterceptors(request: request, types: [.generalPurpose])
        return try await requestService.performRequest(request)
    }
    
    public func performRequest<T>(_ request: URLRequest) async throws -> T where T : Decodable {
        let request = try await runInterceptors(request: request, types: [.generalPurpose])
        return try await requestService.performRequest(request)
    }
    
    private func runInterceptors(request: URLRequest, types: [HTTPRequestInterceptorType]) async throws -> URLRequest {
        var request = request
        for interceptor in requestInterceptors {
            guard types.contains(interceptor.type) else { continue }            
            request = try await interceptor.interceptRequest(request)
        }
        return request
    }
}
