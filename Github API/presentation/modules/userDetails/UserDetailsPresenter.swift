//  
//  UserDetailsPresenter.swift
//  Github API
//
//  Created by Junio Moquiuti on 26/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxCocoa

final class UserDetailsPresenter: BasePresenter {
    
    private let interactor: UserDetailsInteractorProtocol
    
    lazy var viewModel = UserDetailsViewModel(user: interactor.user)
    
    init(interactor: UserDetailsInteractorProtocol) {
        self.interactor = interactor
        super.init()
    }
}

// MARK: - UserDetailsPresenterProtocol
extension UserDetailsPresenter: UserDetailsPresenterProtocol {
    
    var title: String {
        return interactor.user.value.name ?? interactor.user.value.login
    }
    
    var userRequestResponse: Driver<Void> {
        return interactor.userRequestResponse
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
    }
}
