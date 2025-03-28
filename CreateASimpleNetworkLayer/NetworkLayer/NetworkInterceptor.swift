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
                return (data, response)
            } catch {
                if shouldRetry(error: error), retries < maxRetryCount {
                    let delay = retryDelay * pow(2.0, Double(retries)) // create a delay for recall
                    print("Retrying request (\(retries + 1)) after \(delay) seconds due to error: \(error.localizedDescription)")
                    
                    try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000)) // Convert seconds to nanoseconds
                    retries += 1
                } else {
                    throw error // If max retries are reached, throw the error
                }
            }
        }
        
        throw URLError(.timedOut) // Fallback error if all retries fail
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
