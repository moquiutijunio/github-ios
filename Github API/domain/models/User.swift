//
//  User.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation

struct User {
    
    var name: String?
    var login: String
    var avatar: URL?
    var bio: String?
    var publicRepos: Int
    var followers: Int
    var following: Int
}


extension User {
        
    static func map(user: UserAPI) -> User? {
        guard let login = user.login else {
            return nil
        }
        
        return User(name: user.name,
                    login: login,
                    avatar: user.avatar,
                    bio: user.bio,
                    publicRepos: user.publicRepos ?? 0,
                    followers: user.followers ?? 0,
                    following: user.following ?? 0)
    }
    
    static func mapArray(users: [UserAPI]) -> [User] {
        return users
            .compactMap { User.map(user: $0) }
    }
}
