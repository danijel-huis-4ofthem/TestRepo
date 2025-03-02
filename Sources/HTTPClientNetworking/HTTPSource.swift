//
//  HTTPSource.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation

public enum HTTPSource: Equatable, Sendable {
    
    /// Full url.
    case url(_ url: URL)
    
    /// Only path, this is appended to base URL of HTTPRequestBuilder.
    case path(_ path: String)
}
