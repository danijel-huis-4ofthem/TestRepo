//
//  HTTPClientError.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation
import UIKit

public enum HTTPClientError: Error, Sendable {
    case failedToConstructURL
    case unableToEncodeStringAsData(String, encoding: String.Encoding)
    case unableToEncodeMultipartImage(UIImage, encoding: MultipartData.UIImageEncoding)
    case badStatusCode(statusCode: Int)
}
