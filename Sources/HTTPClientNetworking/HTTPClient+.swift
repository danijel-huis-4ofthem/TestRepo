//
//  File.swift
//  HTTPClientNetworking
//
//  Created by Danijel Huis on 11.02.2025..
//

import Foundation

extension HTTPClient {
    /// Downloads file and returns data.
    public func downloadFile(url: URL) async throws -> Data {
        let request = try await buildRequest(method: .get, source: .url(url), query: nil, headers: nil, body: nil)
        let data = try await performRequest(request)
        return data
    }
    
    /// Downloads file and saves it to temporary location. Returns url of temporary location. If fileName is nil it will take lastPathComponent.
    public func downloadFileToTemporaryURL(url: URL, fileName: String?) async throws -> URL {
        // Download file.
        let data = try await downloadFile(url: url)
        
        // Create temporary url.
        let temporaryURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName ?? url.lastPathComponent)
        
        // Save file to temporary location (this will overwrite it).
        try data.write(to: temporaryURL, options: .atomic)
        return temporaryURL
    }
}
