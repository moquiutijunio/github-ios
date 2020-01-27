//
//  Repository.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation

struct Repository {
    
    var name: String
    var description: String?
    var stargazersCount: Int
}


extension Repository {
        
    static func map(repository: RepositoryAPI) -> Repository? {
        guard let name = repository.name else {
            return nil
        }
        
        return Repository(name: name,
                    description: repository.description,
                    stargazersCount: repository.stargazersCount ?? 0)
    }
    
    static func mapArray(repositories: [RepositoryAPI]) -> [Repository] {
        return repositories
            .compactMap { Repository.map(repository: $0) }
    }
}
