//
//  UserDetailsViewModel.swift
//  Github API
//
//  Created by Junio Moquiuti on 26/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class UserDetailsViewModel: NSObject {
    
    private let user: BehaviorRelay<User>
    
    init(user: BehaviorRelay<User>) {
        self.user = user
    }
}

// MARK: - UserDetailsViewModelProtocol
extension UserDetailsViewModel: UserDetailsViewModelProtocol {
    
    var bio: Driver<String?> {
        return user
            .asDriver()
            .map { $0.bio }
    }
    
    var name: Driver<String?> {
        return user
            .asDriver()
            .map { $0.name }
    }
    
    var avatar: Driver<URL?> {
        return user
            .asDriver()
            .map { $0.avatar }
    }
    
    var followers: Driver<String> {
        return user
            .asDriver()
            .map { (user) -> String in
                let localizedString = NSLocalizedString("user.followers", comment: "")
                return String(format: localizedString, user.followers.description)
            }
    }
    
    var following: Driver<String> {
        return user
            .asDriver()
            .map { (user) -> String in
                let localizedString = NSLocalizedString("user.following", comment: "")
                return String(format: localizedString, user.following.description)
            }
    }
    
    var publicRepositories: Driver<String> {
        return user
            .asDriver()
            .map { (user) -> String in
                let localizedString = NSLocalizedString("user.public.repositories", comment: "")
                return String(format: localizedString, user.publicRepos.description)
            }
    }
    
    var followersAttributedText: Driver<NSMutableAttributedString> {
        return user
        .asDriver()
        .map { (user) -> NSMutableAttributedString in
            let localizedString = NSLocalizedString("user.followers", comment: "")
            let text = String(format: localizedString, user.followers.description)
            let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: text))
            let descriptionRange = (text as NSString).range(of: user.followers.description)
            attributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: descriptionRange)
            return attributedText
        }
    }
    
    var followingsAttributedText: Driver<NSMutableAttributedString> {
        return user
        .asDriver()
        .map { (user) -> NSMutableAttributedString in
            let localizedString = NSLocalizedString("user.following", comment: "")
            let text = String(format: localizedString, user.following.description)
            let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: text))
            let descriptionRange = (text as NSString).range(of: user.following.description)
            attributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: descriptionRange)
            return attributedText
        }
    }
    
    var publicRepositoriesAttributedText: Driver<NSMutableAttributedString> {
        return user
        .asDriver()
        .map { (user) -> NSMutableAttributedString in
            let localizedString = NSLocalizedString("user.public.repositories", comment: "")
            let text = String(format: localizedString, user.publicRepos.description)
            let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: text))
            let descriptionRange = (text as NSString).range(of: user.publicRepos.description)
            attributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: descriptionRange)
            return attributedText
        }
    }
}
