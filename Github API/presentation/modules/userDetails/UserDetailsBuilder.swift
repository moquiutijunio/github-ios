//  
//  UserDetailsBuilder.swift
//  Github API
//
//  Created by Junio Moquiuti on 26/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit

enum UserDetailsBuilder {
 
    static func build(user: User) -> UIViewController {
        let repository = UserRepository()
        let interactor = UserDetailsInteractor(user: user, repository: repository)
        let presenter = UserDetailsPresenter(interactor: interactor)
        return UserDetailsViewController(presenter: presenter)
    }
}
