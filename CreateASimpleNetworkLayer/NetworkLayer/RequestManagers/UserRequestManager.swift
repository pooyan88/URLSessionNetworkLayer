import Foundation

enum UserRequestManager: AsURLRequest {
    
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
}


