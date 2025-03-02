//
//  File.swift
//  HTTPClientNetworking
//
//  Created by Danijel Huis on 12.02.2025..
//

import Foundation

struct GraphQLBody: Encodable, Sendable {
    let query: String
}
