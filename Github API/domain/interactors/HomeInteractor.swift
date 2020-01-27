//  
//  HomeInteractor.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import RxSwift
import RxCocoa

protocol HomeInteractorProtocol {
    
    var userRequestResponse: Observable<RequestResponse<[User]>> { get }
    func queryDidChange(_ newQuery: String)
}

final class HomeInteractor: BaseInteractor {
 
    private let repository: UserRepositoryProtocol
    private var queryDisposeBag: DisposeBag!
    
    private let userRequest = BehaviorSubject<RequestResponse<[User]>>(value: .new)
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
        super.init()
    }
    
    private func requestQuery(_ query: String) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            userRequest.onNext(.new)
            return
        }
        
        queryDisposeBag = DisposeBag()
        userRequest.onNext(.loading)
        
        repository
            .searchUser(by: query)
            .subscribe { (event) in
                switch event {
                case .success(let usersAPI):
                    self.userRequest.onNext(.success(User.mapArray(users: usersAPI)))
                    
                case .error(let error):
                    self.userRequest.onNext(.failure(error))
                }
            }
            .disposed(by: queryDisposeBag)
    }
}

// MARK: - HomeInteractorProtocol
extension HomeInteractor: HomeInteractorProtocol {
        
    var userRequestResponse: Observable<RequestResponse<[User]>> {
        return userRequest
    }
    
    func queryDidChange(_ newQuery: String) {
        requestQuery(newQuery)
    }
}
