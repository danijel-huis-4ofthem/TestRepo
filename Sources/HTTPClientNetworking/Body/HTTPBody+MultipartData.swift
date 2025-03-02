//
//  HTTPBody+MultipartData.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation
import UIKit

public enum MultipartData: Sendable {
    
    case parameter(name: String, value: String)
    case file(name: String, type: FileType, url: URL)
    case image(name: String, image: UIImage, encoding: UIImageEncoding)
    
    public enum FileType: Sendable {
        case other(String)
        
        // TODO: Check if uploading all files prepends the filetype with 'file/'
        var mimeType: String {
            return switch self {
            case let .other(type): type
            }
        }
    }
    
    public enum UIImageEncoding: Sendable {
        case jpg(quality: Float)
        case png
        
        var fileExtension: String {
            switch self {
            case .jpg:
                return "jpg"
            case .png:
                return "png"
            }
        }
    }
}

extension MultipartData {
    
    var name: String {
        switch self {
        case let .parameter(name, _):
            return name
        case let .file(name, _, _):
            return name
        case let .image(name, _, _):
            return name
        }
    }
    
    var fileName: String? {
        switch self {
        case .parameter:
            return nil
        case let .file(name, type, _):
            return "\(name).\(type)"
        case let .image(name, _, encoding):
            return "\(name).\(encoding.fileExtension)"
        }
    }
    
    var mimeType: String? {
        switch self {
        case .parameter:
            return nil
        case let .file(_, type, _):
            return type.mimeType
        case let .image(_, _, encoding):
            return "image/\(encoding.fileExtension)"
        }
    }
}
