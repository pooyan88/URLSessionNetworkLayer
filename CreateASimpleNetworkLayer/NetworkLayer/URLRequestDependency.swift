//
//  URLRequestDependency.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

protocol AsURLRequest {
    var timeOutDuration: TimeInterval { get }
    var method: String { get }
    var header: String? { get }
    var body: String? { get }
    var url: URL { get }
    var queryItems: [URLQueryItem]? { get }
    func asURLRequest() throws -> URLRequest
}

extension AsURLRequest {
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = self.method
        urlRequest.timeoutInterval = self.timeOutDuration
        
        // Set header if available
        if let header = self.header {
            urlRequest.setValue(header, forHTTPHeaderField: "Content-Type")
        }
        
        // Set body if available
        if let body = self.body {
            urlRequest.httpBody = body.data(using: .utf8)
        }
        
        // Add query items if available
        if let queryItems = self.queryItems {
            var urlComponents = URLComponents(url: self.url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryItems
            if let modifiedURL = urlComponents?.url {
                urlRequest.url = modifiedURL
            }
        }
        
        return urlRequest
    }

}
