//
//  APIClient.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation
import RxSwift

protocol APIClientProtocol {
    
    func userDetails(user: String) -> Single<UserAPI>
    func searchUser(by query: String) -> Single<[UserAPI]>
    func searchRepositories(user: String, page: Int) -> Single<[RepositoryAPI]>
}

final class APIClient: APIClientProtocol {
    
    func userDetails(user: String) -> Single<UserAPI> {
        
        return Single.create { [weak self] (single) -> Disposable in
            guard let self = self else {
                single(.error(APIClient.error(description: NSLocalizedString("generic.request.error", comment: ""))))
                return Disposables.create()
            }
            
            self.request(.userDetails(user: user)) { (result) in
                
                switch result {
                case .success(let data):
                    if let userAPI = UserAPI.map(data: data) {
                        single(.success(userAPI))
                        
                    } else {
                        single(.error(APIClient.error(description: NSLocalizedString("generic.request.error", comment: ""))))
                    }
                    
                case .failure(let error):
                    single(.error(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    func searchRepositories(user: String, page: Int) -> Single<[RepositoryAPI]> {
        
        return Single.create { [weak self] (single) -> Disposable in
            guard let self = self else {
                single(.error(APIClient.error(description: NSLocalizedString("generic.request.error", comment: ""))))
                return Disposables.create()
            }
            
            self.request(.searchRepositories(user: user, page: page)) { (result) in
                
                switch result {
                case .success(let data):
                    if let repositoriesAPI = RepositoryAPI.mapArray(data: data) {
                        single(.success(repositoriesAPI))
                        
                    } else {
                        single(.error(APIClient.error(description: NSLocalizedString("generic.request.error", comment: ""))))
                    }
                    
                case .failure(let error):
                    single(.error(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    func searchUser(by query: String) -> Single<[UserAPI]> {
        
        return Single.create { [weak self] (single) -> Disposable in
            guard let self = self else {
                single(.error(APIClient.error(description: NSLocalizedString("generic.request.error", comment: ""))))
                return Disposables.create()
            }
            
            self.request(.searchUsers(query: query)) { (result) in
                
                switch result {
                case .success(let data):
                    if let usersAPI = UserAPI.mapArray(data: data) {
                        single(.success(usersAPI))
                        
                    } else {
                        single(.error(APIClient.error(description: NSLocalizedString("generic.request.error", comment: ""))))
                    }
                    
                case .failure(let error):
                    single(.error(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
