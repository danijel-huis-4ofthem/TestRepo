//
//  HTTPClientLogger.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation


struct HTTPClientLogger: Sendable {

    @MainActor
    static func log(request: URLRequest, response: URLResponse? = nil, data: Data? = nil, error: Error? = nil, logLevel: HTTPClientLogLevel) {
#if !DEBUG
        return
#endif
        guard logLevel != .none else { return }
         
        let response = response as? HTTPURLResponse
        
        let source = "HTTP \(response?.statusCode ?? -1) [\(request.httpMethod ?? "Unknown method")] \(request.url?.absoluteString ?? "Empty URL")"
        let headers = request.allHTTPHeaderFields?.reduce(into: [String]()) { partialResult, keyValue in
            partialResult.append("\(keyValue.key) = \(keyValue.value)")
        }.joined(separator: "\n")
        let body = if let body = request.httpBody { String(data: body , encoding: .utf8) } else { Optional<String>(nil) }
        let responseString = if let data = data { String(data: data, encoding: .utf8) } else { Optional<String>(nil) }
        let errorString = if let error = error { "\(error)" } else { Optional<String>(nil) }
        
        let text = [
            "================================================== START",
            source,
            "HEADERS: \(headers ?? "Empty")",
            "BODY: \(body ?? "Empty")",
            "RESPONSE: \(responseString ?? "Empty")",
            "ERROR: \(errorString ?? "Empty")",
            "================================================== END"
        ].joined(separator: "\n")
        
        print(text)
    }
    
    @MainActor
    static func log(prefix: String, error: Error, logLevel: HTTPClientLogLevel) {
#if !DEBUG
        return
#endif
        guard logLevel != .none else { return }
        
        print("\(prefix): \(error)")
    }
}

public enum HTTPClientLogLevel: Sendable {
    case none
    case verbose
}
