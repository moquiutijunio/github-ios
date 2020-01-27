//
//  UserRepository.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepositoryProtocol {
    
    func userDetails(user: String) -> Single<UserAPI>
    func searchUser(by query: String) -> Single<[UserAPI]>
    func searchRepositories(user: String, page: Int) -> Single<[RepositoryAPI]>
}

final class UserRepository: BaseRepository, UserRepositoryProtocol {
    
    func userDetails(user: String) -> Single<UserAPI> {
        return apiClient
            .userDetails(user: user)
    }
    
    func searchUser(by query: String) -> Single<[UserAPI]> {
        return apiClient
            .searchUser(by: query)
    }
    
    func searchRepositories(user: String, page: Int) -> Single<[RepositoryAPI]> {
        return apiClient
            .searchRepositories(user: user, page: page)
    }
}
