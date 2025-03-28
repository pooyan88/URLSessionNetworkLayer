//
//  WebService.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

 class WebService {
    
    enum RequestError: Error {
        case invalidURL
        case decodingFailed
        case badServerResponse
        case customError(String)
    }
    
    private let interceptor = NetworkInterceptor() // Use the interceptor
    private let factory = RequestFactory()
        
     func baseRequest<T: Codable>(feature: APIFeature) async throws -> T {
        // Generate the request using the feature
        let requestManager = factory.createRequest(for: feature)
        
        // Make the actual request using the interceptor
        let (data, response) = try await interceptor.request(try requestManager.asURLRequest())
        
        // Handle HTTP response
        if let response = response as? HTTPURLResponse {
            print("HTTP Response: \(response.statusCode)")
            switch response.statusCode {
            case 200...299:
                print("Request Succeeded Code ==> \(response.statusCode)")
            case 400...499:
                print("Client Error: \(response.statusCode)")
                throw RequestError.customError("Client error, status: \(response.statusCode)")
            case 500...599:
                print("Server Error: \(response.statusCode)")
                throw RequestError.customError("Server error, status: \(response.statusCode)")
            default:
                print("Unhandled status code: \(response.statusCode)")
            }
        }
        
        if let rawString = String(data: data, encoding: .utf8) {
            print("Raw Response Data: \(rawString)")
        }
        
        // Decode the data into the model
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Failed to decode data: \(error.localizedDescription)")
            throw RequestError.decodingFailed
        }
    }
}
