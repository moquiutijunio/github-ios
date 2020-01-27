//
//  UserDetailsCardViewModel.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation

final class UserDetailsCardViewModel: NSObject, UserDetailsCardViewModelProtocol {
    
    private(set) var user: User
    var avatar: URL?
    var name: String?
    var login: String?
    
    init(user: User) {
        self.user = user
        self.avatar = user.avatar
        self.name = user.name
        self.login = user.login
    }
}
