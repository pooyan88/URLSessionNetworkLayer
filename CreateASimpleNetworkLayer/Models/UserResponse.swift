//
//  UserResponse.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

struct User: Codable {
    let ID: Int
    let name: String
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case ID = "id"
        case name
        case username
    }
}
