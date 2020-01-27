//
//  RepositoryDetailsTableViewCell.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import Kingfisher

protocol RepositoryDetailsViewModelProtocol {
    
    var name: String { get }
    var stargazers: String? { get }
    var informations: String? { get }
}

final class RepositoryDetailsTableViewCell: UITableViewCell {
    static let reuseId = "RepositoryDetailsTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stargazersLabel: UILabel!
    @IBOutlet weak var informationsLabel: UILabel!
    @IBOutlet weak var stargazersImageView: UIImageView!
    
    private var viewModel: RepositoryDetailsViewModelProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyAppearance()
    }
    
    private func applyAppearance() {
        backgroundColor = .clear
        selectionStyle = .none
        
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.font = .boldSystemFont(ofSize: 22)
        
        stargazersLabel.textColor = .lightGray
        stargazersLabel.textAlignment = .left
        stargazersLabel.font = .systemFont(ofSize: 8)
        
        informationsLabel.numberOfLines = 3
        informationsLabel.textColor = .lightGray
        informationsLabel.textAlignment = .left
        informationsLabel.font = .systemFont(ofSize: 14)
        
        stargazersImageView.image = UIImage(named: "ic_star")?.withRenderingMode(.alwaysTemplate)
        stargazersImageView.tintColor = .lightGray
        stargazersImageView.contentMode = .scaleAspectFit
    }
    
    func bindIn(viewModel: RepositoryDetailsViewModelProtocol) {
        
        nameLabel.text = viewModel.name
        stargazersLabel.text = viewModel.stargazers
        informationsLabel.text = viewModel.informations
        
        self.viewModel = viewModel
    }
}
