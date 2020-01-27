//
//  APITarget.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation

enum APITarget {
    
    case userDetails(user: String)
    case searchUsers(query: String)
    case searchRepositories(user: String, page: Int)
}

extension APITarget {
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        return request
    }
    
    var url: URL {
        let baseURLString = "https://api.github.com"
        let urlString = "\(baseURLString)\(path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: urlString)!
    }
    
    var path: String {
        switch self {
        case .searchUsers(let query):
            return "/search/users?q=\(query)"
            
        case .searchRepositories(let params):
            return "/users/\(params.user)/repos?page=\(params.page)"
            
        case .userDetails(let user):
            return "/users/\(user)"
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "authorization": authenticationHeader
        ]
    }
    
    var authenticationHeader: String {
        guard let auth = "\(Credentials.username):\(Credentials.accessToken)".data(using: String.Encoding.utf8) else {
            fatalError("Unable to generate authentication header, check username and accessToken in Credentials.swift")
        }
        
        return "Basic \(auth.base64EncodedString())"
    }
    
    var httpMethod: String {
        return "GET"
    }
}
