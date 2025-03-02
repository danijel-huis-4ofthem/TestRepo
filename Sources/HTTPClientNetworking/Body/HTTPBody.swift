//
//  HTTPBody.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation
import UIKit

public enum HTTPBody: Sendable {
    case raw(Data)
    case formData([String: String])
    case multipart(boundary: UUID = UUID(), [MultipartData])
    case json(Encodable & Sendable)
    case string(String, encoding: String.Encoding = .utf8)
    case graphQL(query: String)
    
    var contentType: String? {
        switch self {
        case .raw:
            return nil
        case .formData:
            return "application/x-www-form-urlencoded"
        case let .multipart(boundary, _):
            return "multipart/form-data; boundary = \(boundary)"
        case .json, .graphQL:
            return "application/json"
        case .string:
            return nil
        }
    }
}
