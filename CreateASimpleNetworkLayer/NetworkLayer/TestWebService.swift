//
//  TestWebService.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

import Foundation

final class TestWebService: NetworkCall {
    
    let factory = RequestFactory()
    
    func baseRequest<T: Codable>(feature: APIFeature) async throws -> T where T : Decodable, T : Encodable {
        let requestManager = factory.createRequest(for: feature)
        
        // Conditional code for loading mock data during tests
        var fileName = ""
        #if CreateASimpleNetworkLayerTests
        if let urlString = requestManager.url?.absoluteString, urlString.contains("post") {
            // Mock response for testing
            fileName = "mockResponse"
        }
        loadFromFile(fileName: fileName)
        #else
        fatalError("No mock data provided for \(feature)")
        #endif
    }
    
    // Method to load mock data from a local file
    func loadFromFile<T: Codable>(fileName: String, bundle: Bundle = .main) async throws -> T {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "TestWebService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Mock file not found"])
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
