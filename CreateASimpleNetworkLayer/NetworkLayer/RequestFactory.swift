//
//  RequestFactory.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

final class RequestFactory {
    func createRequest(for feature: APIFeature) -> AsURLRequest {
        switch feature {
        case .posts(let requestManager):
            return requestManager
        case .users(let requestManager):
            return requestManager
        }
    }
}
