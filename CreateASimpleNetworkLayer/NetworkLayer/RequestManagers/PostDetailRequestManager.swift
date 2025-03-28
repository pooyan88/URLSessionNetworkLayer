//
//  PostDetailRequestManager.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

enum PostDetailRequestManager: AsURLRequest {
    
    case postDetail(postID: Int)
    
    var timeOutDuration: TimeInterval {
        switch self {
        case .postDetail:
            return 10
        }
    }
    
    var method: String {
        switch self {
        case .postDetail:
            return "GET"
        }
    }
    
    var header: String? {
        switch self {
        case .postDetail:
            return "application/json"
        }
    }
    
    var body: String? {
        switch self {
        case .postDetail:
            return nil
        }
    }
    
    var url: URL {
        switch self {
        case .postDetail(let id):
            return URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")!
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .postDetail:
            return nil
        }
    }
}
