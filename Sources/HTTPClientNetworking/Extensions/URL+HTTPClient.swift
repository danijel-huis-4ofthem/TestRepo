//
//  URL+Path.swift
//
//  Created by Danijel Huis
//

import Foundation

extension URL {
    
    /// Appends path. Intended to be used for remote urls. Same as append(path:) but solves some problems with double slashes.
    func appending(unsanitizedPath path: String?) -> URL {
        // If we don't do this check it will add slash at the end (not wrong but this is better).
        guard var path = path, !path.isEmpty else { return self }
        guard !isFileURL else { return appendingPathComponent(path) }
        
        // If base ends with slash and path starts with slash then we get double slash between base and path.
        if absoluteString.hasSuffix("/") && path.hasPrefix("/") {
            path.removeFirst()
        }
        
        // Note: be careful if upgrading to `appending(path: path)`. It adds double slash at end if path ends with slash.
        return appendingPathComponent(path)
    }
        
    /// Appends query, items are alphabetically sorted and percent escaped.
    func appending(query: [String: String]?) -> URL? {
        guard let query = query, !query.isEmpty else { return self }
        
        // Sorting query parameters because of URLCache and easier unit testing.
        let sortedQueryItems = query
            .sorted(by: { $0.key < $1.key })    
            .map({ URLQueryItem(name: $0.key, value: $0.value) })
        
        // Note: Use appending(queryItems:) on iOS 16.
        if #available(iOS 16.0, *) {
            return appending(queryItems: sortedQueryItems)
        } else {
            if var components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
                components.queryItems = sortedQueryItems
                return components.url
            } else {
                return nil
            }
        }
    }
}
