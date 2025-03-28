//
//  APICalls.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

// MARK: - Feature: Users
extension WebService {
    func fetchUsers() async throws -> [User] {
        let requestManager: UserRequestManager = .getUsers
        return try await baseRequest(feature: .users(requestManager))
    }
}

// MARK: - Feature: Post Details
extension WebService {
    func fetchPostDetails(id: Int) async throws -> PostDetailsResponse {
        let requestManager: PostDetailRequestManager = .postDetail(postID: id)
        return try await baseRequest(feature: .posts(requestManager))
    }
}
