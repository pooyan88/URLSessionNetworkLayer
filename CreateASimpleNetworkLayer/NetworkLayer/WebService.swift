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
    
    // Function to perform the base request and decode the result
    func baseRequest<T: Codable>(_ request: RequestManager) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: try request.asURLRequest())
        
        // Debugging: Print the raw data and the response
        if let response = response as? HTTPURLResponse {
            print("HTTP Response: \(response.statusCode)")
            switch response.statusCode {
            case 200...300:
                dump("Request Succeed Code ==> \(response.statusCode)")
            case 400...500:
                dump("Request Failed Code ==> \(response.statusCode)")
            default:
                dump(response.statusCode)
            }
        }
        
        // Print raw response data for debugging
        if let rawString = String(data: data, encoding: .utf8) {
            print("Raw Response Data: \(rawString)")
        }
        
        // Check if data is empty
        if data.isEmpty {
            throw RequestError.decodingFailed
        }
        
        // Try decoding the data into the expected model
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Failed to decode data: \(error.localizedDescription)")
            throw RequestError.decodingFailed
        }
    }
}

// WebService Extension for specific fetch function
extension WebService {
    func fetchUsers() async throws -> [User] {
        return try await baseRequest(.getUsers)
    }
}
