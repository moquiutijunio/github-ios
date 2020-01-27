//
//  RepositoryAPI.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation

struct RepositoryAPI: Codable {
    
    var id: Int?
    var name: String?
    var description: String?
    var stargazersCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case stargazersCount = "stargazers_count"
    }
}

extension RepositoryAPI {
    
    static func mapArray(data: Data) -> [RepositoryAPI]? {
        guard let repositories = try? JSONDecoder().decode([RepositoryAPI].self, from: data) else {
                return nil
        }
        
        return repositories
    }
}
