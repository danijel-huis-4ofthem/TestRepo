//
//  URLSessionRequestService.swift
//
//
//  Created by Danijel Huis
//

import Foundation
import UIKit

// MARK: - HTTPRequestService -

/// Performs request and decodes response using URLSession.
public final class URLSessionRequestService: HTTPRequestService {
    
    private let session: URLSession
    private let logLevel: HTTPClientLogLevel
    
    /// If there is need for xml or something else then replace this with `TopLevelDecoder` (it will need to be generic).
    private let decoder: JSONDecoder
    
    public init(session: URLSession = URLSession(configuration: .default), decoder: JSONDecoder, logLevel: HTTPClientLogLevel = .none) {
        self.session = session
        self.decoder = decoder
        self.logLevel = logLevel
    }
    
    /// Performs given request, decodes raw data and returns data and response.
    public func performRequest(_ request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await session.data(for: request)
            if let response = response as? HTTPURLResponse, response.statusCode >= 400 {
                throw HTTPClientError.badStatusCode(statusCode: response.statusCode)
            }            
            await HTTPClientLogger.log(request: request, response: response, data: data, error: nil, logLevel: logLevel)
            return data
        } catch {
            await HTTPClientLogger.log(request: request, response: nil , data: nil, error: error, logLevel: logLevel)
            throw error
        }
    }
    
    /// Performs given request, decodes raw data and returns decoded object.
    public func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let data = try await performRequest(request)
            return try decoder.decode(T.self, from: data)
        } catch {
            await HTTPClientLogger.log(prefix: "Decoding error", error: error, logLevel: logLevel)
            throw error
        }
    }
}
