//
//  HTTPRequestService.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation

public protocol HTTPRequestService: Sendable {
    
    /// Performs request and returns data and response.
    func performRequest(_ request: URLRequest) async throws -> Data
    
    /// Performs request and decodes response.
    func performRequest<T>(_ request: URLRequest) async throws -> T where T : Decodable
}
