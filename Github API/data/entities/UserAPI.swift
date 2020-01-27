//
//  UserAPI.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation

struct UserAPI: Codable {
    
    var id: Int?
    var name: String?
    var login: String?
    var type: String?
    var avatar: URL?
    var company: String?
    var location: String?
    var email: String?
    var bio: String?
    var publicRepos: Int?
    var followers: Int?
    var following: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case login
        case type
        case avatar = "avatar_url"
        case company
        case location
        case email
        case bio
        case publicRepos = "public_repos"
        case followers
        case following
    }
}

extension UserAPI {
        
    static func map(data: Data) -> UserAPI? {
        guard let user = try? JSONDecoder().decode(UserAPI.self, from: data) else {
            return nil
        }
        
        return user
    }
    
    static func mapArray(data: Data) -> [UserAPI]? {
        guard let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary,
            let usersJson = jsonObj.value(forKey: "items") as? NSArray,
            let data = try? JSONSerialization.data(withJSONObject: usersJson, options: .prettyPrinted),
            let users = try? JSONDecoder().decode([UserAPI].self, from: data) else {
            return nil
        }
        
        return users
    }
}
