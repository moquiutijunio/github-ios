//  
//  UserRepositoriesInteractor.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import RxSwift

protocol UserRepositoriesInteractorProtocol {
    
    var user: User { get }
    var userRepositoriesRequestResponse: Observable<RequestResponse<[Repository]>> { get }
    
    func requestRepositories()
    func requestMoreRepositories()
    func tryAgainLoadingRepositories()
}

final class UserRepositoriesInteractor: BaseInteractor {
 
    private let repository: UserRepositoryProtocol
    private var repositoriesDisposeBag: DisposeBag!
    
    let user: User
    private var currentPage: Int = 1
    private let userRepositoriesRequest = BehaviorSubject<RequestResponse<[Repository]>>(value: .new)
    
    public init(user: User, repository: UserRepositoryProtocol) {
        self.user = user
        self.repository = repository
        super.init()
    }
}

// MARK: - UserRepositoriesInteractorProtocol
extension UserRepositoriesInteractor: UserRepositoriesInteractorProtocol {
    
    var userRepositoriesRequestResponse: Observable<RequestResponse<[Repository]>> {
        return userRepositoriesRequest
    }
    
    func requestRepositories() {
        repositoriesDisposeBag = DisposeBag()
        userRepositoriesRequest.onNext(.loading)
        
        repository
            .searchRepositories(user: user.login, page: currentPage)
            .subscribe { (event) in
                switch event {
                case .success(let repositoriesAPI):
                    self.userRepositoriesRequest.onNext(.success(Repository.mapArray(repositories: repositoriesAPI)))
                    
                case .error(let error):
                    self.userRepositoriesRequest.onNext(.failure(error))
                }
            }
            .disposed(by: repositoriesDisposeBag)
    }
    
    func requestMoreRepositories() {
        currentPage += 1
        requestRepositories()
    }
    
    func tryAgainLoadingRepositories() {
        requestRepositories()
    }
}
