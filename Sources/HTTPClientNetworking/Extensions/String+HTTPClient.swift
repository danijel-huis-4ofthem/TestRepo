//
//  String+HTTPClient.swift
//  HTTPClientNetworking
//
//  Created by Bruno Benčević on 16.09.2024..
//

import Foundation

extension String {
    
    static var carriageReturnNewLine: String {
        "\r\n"
    }
    
    func encoded(using encoding: Encoding) throws -> Data {
        if let data = self.data(using: encoding) {
            return data
        } else {
            throw HTTPClientError.unableToEncodeStringAsData(self, encoding: encoding)
        }
    }
}
