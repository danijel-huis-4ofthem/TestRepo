//
//  HTTPRequestInterceptor.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation

public protocol HTTPRequestInterceptor: Sendable {
    var type: HTTPRequestInterceptorType { get }
    func interceptRequest(_ request: URLRequest) async throws -> URLRequest
}

public enum HTTPRequestInterceptorType: Sendable {
    /// If interceptor is marked as authorizer then it will be called only if authorizeRequest is called on HTTPClient.
    case authorizer
    /// Interceptor that is always called on all requests.
    case generalPurpose
}
