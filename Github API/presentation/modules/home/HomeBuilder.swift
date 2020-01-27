//  
//  HomeBuilder.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit

enum HomeBuilder {
 
    static func build(router: HomeRouterProtocol) -> UIViewController {
        let repository = UserRepository()
        let interactor = HomeInteractor(repository: repository)
        let presenter = HomePresenter(interactor: interactor)
        presenter.router = router
        return HomeViewController(presenter: presenter)
    }
}
