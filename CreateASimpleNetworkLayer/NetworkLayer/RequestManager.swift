import Foundation

enum RequestManager: AsURLRequest {
    
    case getUsers
    
    var timeOutDuration: TimeInterval {
        switch self {
        case .getUsers:
            return 60
        }
    }
    var method: String {
        switch self {
        case .getUsers:
            return "GET"
        }
    }
    var header: String? {
        switch self {
        case .getUsers:
            return "application/json"
        }
    }
    var body: String? {
        switch self {
        case .getUsers:
            return nil
        }
    }
    var url: URL {
        switch self {
        case .getUsers:
            return URL(string: "https://jsonplaceholder.typicode.com/users")!
        }
    }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getUsers:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = self.method
        urlRequest.timeoutInterval = self.timeOutDuration
        
        // Set header if available
        if let header = self.header {
            urlRequest.setValue(header, forHTTPHeaderField: "Content-Type")
        }
        
        // Set body if available
        if let body = self.body {
            urlRequest.httpBody = body.data(using: .utf8)
        }
        
        // Add query items if available
        if let queryItems = self.queryItems {
            var urlComponents = URLComponents(url: self.url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryItems
            if let modifiedURL = urlComponents?.url {
                urlRequest.url = modifiedURL
            }
        }
        
        return urlRequest
    }
}

