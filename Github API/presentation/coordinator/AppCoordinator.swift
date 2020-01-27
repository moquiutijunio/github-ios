//
//  AppCoordinator.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit

final class AppCoordinator: NSObject {
    
    private var window: UIWindow
    private var navigationController: UINavigationController
    
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        self.navigationController = UINavigationController()
        super.init()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showHomeViewController() {
        let homeViewController = HomeBuilder.build(router: self)
        navigationController.setViewControllers([homeViewController], animated: true)
    }
}

// MARK: - HomeRouterProtocol
extension AppCoordinator: HomeRouterProtocol {
    
    func showUserRepositories(_ user: User) {
        let userRepositoriesViewController = UserRepositoriesBuilder.build(user: user, router: self)
        navigationController.pushViewController(userRepositoriesViewController, animated: true)
    }
}

// MARK: - UserRepositoriesRouterProtocol
extension AppCoordinator: UserRepositoriesRouterProtocol {
    
    func showUserDetails(_ user: User) {
        let userDetailsViewController = UserDetailsBuilder.build(user: user)
        navigationController.pushViewController(userDetailsViewController, animated: true)
    }
}
