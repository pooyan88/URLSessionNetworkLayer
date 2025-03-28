//
//  WebService.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

final class WebService {
    
    enum RequestError: Error {
        case invalidURL
        case decodingFailed
    }
    
    private let interceptor = NetworkInterceptor() // Use the interceptor
    
    func baseRequest<T: Codable>(_ request: RequestManager) async throws -> T {
        
        let (data, response) = try await interceptor.request(request.asURLRequest())
        
        if let response = response as? HTTPURLResponse {
            print("HTTP Response: \(response.statusCode)")
            switch response.statusCode {
            case 200...299:
                dump("Request Succeed Code ==> \(response.statusCode)")
            case 400...499:
                dump("Request Failed Code ==> \(response.statusCode)")
            default:
                dump(response.statusCode)
            }
        }
        
        if let rawString = String(data: data, encoding: .utf8) {
            print("Raw Response Data: \(rawString)")
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Failed to decode data: \(error.localizedDescription)")
            throw RequestError.decodingFailed
        }
    }
}

extension WebService {
    func fetchUsers() async throws -> [User] {
        return try await baseRequest(.getUsers)
    }
}
