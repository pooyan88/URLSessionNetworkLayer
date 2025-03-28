//
//  PostDetailsResponse.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

struct PostDetailsResponse: Codable {
    var userID: Int
    var ID: Int
    var title: String
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case ID = "id"
        case title
        case body
    }
}
