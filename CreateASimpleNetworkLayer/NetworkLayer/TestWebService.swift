//
//  TestWebService.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

final class TestWebService: WebService {
    
    let factory = RequestFactory()
    
    override func baseRequest<T: Codable>(feature: APIFeature) async throws -> T where T : Decodable, T : Encodable {
    
        return PostDetailsResponse(userID: 10000, ID: 10000, title: "mock title", body: "mock body") as! T
    }
    
    // Method to load mock data from a local file
    func loadFromFile<T: Codable>(fileName: String) async throws -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("\(fileName) not found")
            throw NSError(domain: "TestWebService", code: 404, userInfo: [NSLocalizedDescriptionKey: "\(fileName) with .json extension not found"])
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
