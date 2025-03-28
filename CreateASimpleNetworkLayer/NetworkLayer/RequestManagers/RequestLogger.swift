//
//  RequestLogger.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

final class RequestLogger {
    
    private var response: HTTPURLResponse
    private var urlRequest: URLRequest
    
    init(response: HTTPURLResponse, urlRequest: URLRequest) {
        self.response = response
        self.urlRequest = urlRequest
    }
    
    func log() {
        logRequestDetails()
        logResponseDetails()
    }
    
    private func logRequestDetails() {
    
        if let method = urlRequest.httpMethod {
            print("METHOD ===> \(method)")
        } else {
            print("METHOD is missing")
        }
        
        // Log query parameters
        if let url = urlRequest.url, let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let queryItems = urlComponents.queryItems {
                print("QUERY ITEMS ===> \(queryItems)")
            } else {
                print("This request has no query items.")
            }
        } else {
            print("URL is missing or invalid.")
        }
        
        // Log headers
        if let header = urlRequest.allHTTPHeaderFields {
            print("REQUEST HEADER ===> \(header)")
        } else {
            print("This request has no headers.")
        }
    }
    
    private func logResponseDetails() {
        print("RESPONSE STATUS CODE ===> \(response.statusCode)")
        
        // Log response headers
        if let header = response.allHeaderFields as? [String: String] {
            print("RESPONSE HEADER ===> \(header)")
        } else {
            print("This response has no headers.")
        }
        
        // Log response URL
        if let url = response.url {
            print("RESPONSE URL ===> \(url)")
        } else {
            print("Response URL is missing.")
        }
    }
}


