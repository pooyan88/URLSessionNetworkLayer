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
