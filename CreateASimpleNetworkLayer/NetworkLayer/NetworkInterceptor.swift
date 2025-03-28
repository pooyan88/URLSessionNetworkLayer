//
//  NetworkInterceptor.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import Foundation

class NetworkInterceptor {
    
    private let maxRetryCount: Int
    private let retryDelay: TimeInterval
    private let session: URLSession
    
    init(maxRetryCount: Int = 3, retryDelay: TimeInterval = 2.0, session: URLSession = .shared) {
        self.maxRetryCount = maxRetryCount
        self.retryDelay = retryDelay
        self.session = session
    }
    
    func request(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        var retries = 0
        
        while retries <= maxRetryCount {
            do {
                let (data, response) = try await session.data(for: urlRequest)
                let logger = RequestLogger(response: response as! HTTPURLResponse, urlRequest: urlRequest)
                logger.log()
                await handleRefreshToken(for: response)
                return (data, response)
            } catch {
                if shouldRetry(error: error), retries < maxRetryCount {
                    let delay = retryDelay * pow(2.0, Double(retries)) // create a delay before recall
                    print("Retrying request (\(retries + 1)) after \(delay) seconds due to error: \(error.localizedDescription)")
                    
                    try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                    retries += 1
                } else {
                    throw error // If max retries are reached, throw the error
                }
            }
        }
        
        throw URLError(.timedOut) // Fallback error if all retries fail
    }
    
    private func handleRefreshToken(for response: URLResponse) async {
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
            print("Token refreshed due to 401 Unauthorized error.")
            
            // Simulating a token refresh request (this is just an example)
            do {
                let newToken = try await refreshAuthToken()
                // Update the token in your session, for example:
                // KeychainManager.shared.token = newToken
                print("New token: \(newToken)")
            } catch {
                print("Failed to refresh token: \(error)")
            }
        }
    }

    private func refreshAuthToken() async throws -> String {
        // Simulating a network call to refresh the token
        // Replace this with the actual network call to refresh the token
        try await Task.sleep(nanoseconds: 2_000_000_000)  // Simulate a 2-second delay
        return "newAuthToken123"  // Return the new token
    }
    
    private func shouldRetry(error: Error) -> Bool {
        let nsError = error as NSError
        let retryableErrors: [URLError.Code] = [
            .timedOut,
            .networkConnectionLost,
            .notConnectedToInternet,
            .badURL,
            .unsupportedURL
        ]
        
        return retryableErrors.contains(URLError.Code(rawValue: nsError.code))
    }
}
