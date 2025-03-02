//
//  HTTPClient+HTTPTask.swift
//  HTTPClientNetworking
//
//  Created by Danijel Huis on 19.02.2025..
//

import Foundation

extension HTTPClient {
    /// Runs http task that returns decodable.
    @discardableResult public func runTask<T: Decodable>(_ task: HTTPTask<T>) async throws -> T {
        var request = try await buildRequest(
            method: task.method,
            source: task.source,
            query: task.query,
            headers: task.headers,
            body: task.body
        )
        
        if task.shouldAuthorize {
            request = try await authorizeRequest(request)
        }
        
        return try await performRequest(request)
    }
    
    /// Runs http task that returns data.
    @discardableResult public func runDataTask(_ task: HTTPTask<Data>) async throws -> Data {
        var request = try await buildRequest(
            method: task.method,
            source: task.source,
            query: task.query,
            headers: task.headers,
            body: task.body
        )
        
        if task.shouldAuthorize {
            request = try await authorizeRequest(request)
        }
        
        return try await performRequest(request)
    }
}
