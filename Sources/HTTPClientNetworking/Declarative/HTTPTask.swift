//
//  HTTPTask.swift
//  HTTPClientNetworking
//
//  Created by Danijel Huis on 19.02.2025..
//

import Foundation

/// Allows to declare whole process (building request, authorizing, performing request and decoding) as single declarative task.
/// Use it in conjunction with HTTPClient.runTask or HTTPClient.runDataTask.
public struct HTTPTask<T>: Sendable {
    public let method: HTTPMethod
    public let source: HTTPSource
    public let query: [String: String]?
    public let headers: [String: String]?
    public let body: HTTPBody?
    public let shouldAuthorize: Bool
    
    public init(method: HTTPMethod, 
                source: HTTPSource, 
                query: [String : String]? = nil, 
                headers: [String : String]? = nil, 
                body: HTTPBody? = nil, 
                shouldAuthorize: Bool = false) {
        self.method = method
        self.source = source
        self.query = query
        self.headers = headers
        self.body = body
        self.shouldAuthorize = shouldAuthorize
    }
}
