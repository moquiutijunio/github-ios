//  
//  UserRepositoriesBuilder.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit

enum UserRepositoriesBuilder {
 
    static func build(user: User, router: UserRepositoriesRouterProtocol) -> UIViewController {
        let repository = UserRepository()
        let interactor = UserRepositoriesInteractor(user: user, repository: repository)
        let presenter = UserRepositoriesPresenter(interactor: interactor)
        presenter.router = router
        return UserRepositoriesViewController(presenter: presenter)
    }
}
