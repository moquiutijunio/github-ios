//
//  UserDetailsView.swift
//  Github API
//
//  Created by Junio Moquiuti on 26/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

protocol UserDetailsViewModelProtocol {
    
    var name: Driver<String?> { get }
    var avatar: Driver<URL?> { get }
    var bio: Driver<String?> { get }
    var followers: Driver<String> { get }
    var following: Driver<String> { get }
    var publicRepositories: Driver<String> { get }
    var followersAttributedText: Driver<NSMutableAttributedString> { get }
    var followingsAttributedText: Driver<NSMutableAttributedString> { get }
    var publicRepositoriesAttributedText: Driver<NSMutableAttributedString> { get }
}

final class UserDetailsView: UIView {
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var publicRepositoriesLabel: UILabel!
    
    private var disposeBag: DisposeBag!
    private var viewModel: UserDetailsViewModelProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyLayout()
    }
    
    private func applyLayout() {
        
        backgroundColor = .clear
        
        bioLabel.numberOfLines = 0
        bioLabel.textColor = .lightGray
        bioLabel.textAlignment = .center
        bioLabel.font = .systemFont(ofSize: 14)
        
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.font = .boldSystemFont(ofSize: 20)
        
        followersLabel.textColor = .lightGray
        followersLabel.textAlignment = .center
        followersLabel.font = .systemFont(ofSize: 14)
        
        followingLabel.textColor = .lightGray
        followingLabel.textAlignment = .center
        followingLabel.font = .systemFont(ofSize: 14)
        
        publicRepositoriesLabel.textColor = .lightGray
        publicRepositoriesLabel.textAlignment = .center
        publicRepositoriesLabel.font = .systemFont(ofSize: 14)
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width/2
    }
    
    private func bindIn(viewModel: UserDetailsViewModelProtocol) {
        disposeBag = DisposeBag()
        
        viewModel.name
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.followers
            .drive(followersLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.following
            .drive(followingLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.bio
            .drive(bioLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.publicRepositories
            .drive(publicRepositoriesLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.avatar
            .drive(onNext: { [avatarImageView = avatarImageView] (url) in
                avatarImageView?.kf.setImage(with: url, placeholder: UIImage(named: "ic_avatar"))
            })
            .disposed(by: disposeBag)
        
        viewModel.followersAttributedText
            .drive(onNext: { [followersLabel = followersLabel] (attributedText) in
                followersLabel?.attributedText = attributedText
            })
            .disposed(by: disposeBag)
        
        viewModel.followingsAttributedText
            .drive(onNext: { [followingLabel = followingLabel] (attributedText) in
                followingLabel?.attributedText = attributedText
            })
            .disposed(by: disposeBag)
        
        viewModel.publicRepositoriesAttributedText
            .drive(onNext: { [publicRepositoriesLabel = publicRepositoriesLabel] (attributedText) in
                publicRepositoriesLabel?.attributedText = attributedText
            })
            .disposed(by: disposeBag)
        
        self.viewModel = viewModel
    }
}

// MARK: - UINib
extension UserDetailsView {
    
    class func instantiateFromNib(viewModel: UserDetailsViewModelProtocol) -> UserDetailsView {
        let view =  UINib(nibName: "UserDetailsView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UserDetailsView
        view.bindIn(viewModel: viewModel)
        return view
    }
}
