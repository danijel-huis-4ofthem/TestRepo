//
//  URLSessionRequestBuilder.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation
import UIKit

public final class URLSessionRequestBuilder: HTTPRequestBuilder {
    
    private let baseURL: URL?
    
    /// Encoder for body. Currently only JSON but if something else is needed we can make it `TopLevelDecoder`.
    private let encoder: JSONEncoder
    
    public init(baseURL: URL?, encoder: JSONEncoder) {
        self.baseURL = baseURL
        self.encoder = encoder
    }
    
    public func buildRequest(method: HTTPMethod, source: HTTPSource, query: [String : String]?, headers: [String: String]?, body: HTTPBody?) async throws -> URLRequest {
        // URL
        let url: URL? = switch source {
        case .url(let url): url
        case .path(let path): baseURL?.appending(unsanitizedPath: path)
        }
        
        guard let url = url?.appending(query: query) else {
            throw HTTPClientError.failedToConstructURL
        }
        var request = URLRequest(url: url)
        
        // Method
        request.httpMethod = method.rawValue
        
        // Headers
        headers?.forEach({ request.setValue($0.value, forHTTPHeaderField: $0.key) })
        
        if let contentType = body?.contentType {
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        
        // Body
        request.httpBody = switch body {
        case let .raw(data):
            data
        case let .multipart(boundary, items):
            try generateMultipartBody(items, boundary: boundary)
        case let .formData(data):
            try generateFormDataBody(data)
        case let .json(encodable):
            try encoder.encode(encodable)
        case let .string(string, encoding):
            try string.encoded(using: encoding)
        case let .graphQL(query):
            try encoder.encode(GraphQLBody(query: query))
        case .none:
            nil
        }
        return request
    }
}

private extension URLSessionRequestBuilder {
    
    func generateFormDataBody(_ data: [String: String]) throws -> Data {
        return try data
            .map { key, value in
                return key + "=" + value
            }
            .joined(separator: "&")
            .encoded(using: .utf8)
    }
    
    func generateMultipartBody(_ data: [MultipartData], boundary: UUID) throws -> Data {
        let boundary = boundary.uuidString
        var body = Data()
        
        for item in data {
            try body += "--\(boundary)" + .carriageReturnNewLine
            try body += "Content-Disposition: form-data; name=\"\(item.name)\""
            
            if let filename = item.fileName {
                try body += "; filename=\"\(filename)\""
            }
            
            try body += .carriageReturnNewLine
            
            if let contentType = item.mimeType {
                try body += "Content-Type: \(contentType)" + .carriageReturnNewLine
            }
            
            try body += .carriageReturnNewLine
            
            try body += {
                switch item {
                case let .parameter(_, value):
                    try value.encoded(using: .utf8)
                case let .file(name, type, url):
                    try generateFileData(name: name, type: type, url: url)
                case let .image(name, image, encoding):
                    try generateImageData(name: name, image: image, encoding: encoding)
                }
            }()
            
            try body += .carriageReturnNewLine
        }
        
        try body += "--\(boundary)--"
        
        return body as Data
    }
    
    func generateImageData(name: String, image: UIImage, encoding: MultipartData.UIImageEncoding) throws -> Data {
        let data: Data?
        
        switch encoding {
        case let .jpg(quality):
            let quality = max(min(quality, 1.0), 0.0)
            
            data = image.jpegData(compressionQuality: CGFloat(quality))
        case .png:
            data = image.pngData()
        }
        
        if let data {
            return data
        } else {
            throw HTTPClientError.unableToEncodeMultipartImage(image, encoding: encoding)
        }
    }    
    
    // Should be refactored to async file loading
    func generateFileData(name: String, type: MultipartData.FileType, url: URL) throws -> Data {
        return try Data(contentsOf: url)
    }
}
