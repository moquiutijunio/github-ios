//
//  RepositoryDetailsViewModel.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation

final class RepositoryDetailsViewModel: NSObject, RepositoryDetailsViewModelProtocol {
    
    var name: String
    var stargazers: String?
    var informations: String?
    
    init(repository: Repository) {
        self.name = repository.name
        self.stargazers = repository.stargazersCount.description
        self.informations = repository.description
    }
}
