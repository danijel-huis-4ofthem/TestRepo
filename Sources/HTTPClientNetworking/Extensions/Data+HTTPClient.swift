//
//  Data+HTTPClient.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation

extension Data {
    
    static func +=(lhs: inout Data, rhs: Data) {
        lhs.append(rhs)
    }
    
    static func +=(lhs: inout Data, rhs: String) throws {
        let data = try rhs.encoded(using: .utf8)
        lhs.append(data)
    }
}
