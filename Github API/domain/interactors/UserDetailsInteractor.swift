//  
//  UserDetailsInteractor.swift
//  Github API
//
//  Created by Junio Moquiuti on 26/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import RxSwift
import RxCocoa

protocol UserDetailsInteractorProtocol {
    
    var user: BehaviorRelay<User> { get }
    var userRequestResponse: Observable<RequestResponse<User>> { get }
}

final class UserDetailsInteractor: BaseInteractor {
 
    private let repository: UserRepositoryProtocol
    
    let user: BehaviorRelay<User>
    
    public init(user: User, repository: UserRepositoryProtocol) {
        self.user = .init(value: user)
        self.repository = repository
        super.init()
    }
}

// MARK: - UserDetailsInteractorProtocol
extension UserDetailsInteractor: UserDetailsInteractorProtocol {
    
    var userRequestResponse: Observable<RequestResponse<User>> {
        return repository
            .userDetails(user: user.value.login)
            .map({ [weak self] (userAPI) -> RequestResponse<User> in
                guard let self = self else {
                    return .new //Error will never happen
                }
                
                guard let user = User.map(user: userAPI) else {
                    return .success(self.user.value) //Ignoring error and returning current user
                }
                
                self.user.accept(user)
                return .success(user)
            })
            .catchError { .just(.failure($0)) }
            .asObservable()
            .startWith(.loading)
    }
}
