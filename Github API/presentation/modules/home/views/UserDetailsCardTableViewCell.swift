//
//  UserDetailsCardTableViewCell.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import Kingfisher

protocol UserDetailsCardViewModelProtocol {
    
    var avatar: URL? { get }
    var name: String? { get }
    var login: String? { get }
}

final class UserDetailsCardTableViewCell: UITableViewCell {
    static let reuseId = "UserDetailsCardTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nextIconImageView: UIImageView!
    
    private var viewModel: UserDetailsCardViewModelProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyAppearance()
    }
    
    private func applyAppearance() {
        backgroundColor = .clear
        selectionStyle = .none
        
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.font = .boldSystemFont(ofSize: 22)
        
        userLabel.textColor = .lightGray
        userLabel.textAlignment = .left
        userLabel.font = .systemFont(ofSize: 14)
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width/2
        
        nextIconImageView.image = UIImage(named: "ic_next")?.withRenderingMode(.alwaysTemplate)
        nextIconImageView.tintColor = .lightGray
        nextIconImageView.contentMode = .scaleAspectFit
    }
    
    func bindIn(viewModel: UserDetailsCardViewModelProtocol) {
        
        nameLabel.text = viewModel.name
        userLabel.text = viewModel.login
        avatarImageView.kf.setImage(with: viewModel.avatar, placeholder: UIImage(named: "ic_avatar"))
        
        self.viewModel = viewModel
    }
}
