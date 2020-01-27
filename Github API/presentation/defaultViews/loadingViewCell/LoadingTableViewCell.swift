//
//  LoadingTableViewCell.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {
    static let reuseId = "LoadingTableViewCell"
    
    @IBOutlet weak var activityIndicationView: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyAppearance()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicationView.startAnimating()
    }
    
    private func applyAppearance() {
        backgroundColor = .clear
        selectionStyle = .none
        
        loadingLabel.text = NSLocalizedString("searching", comment: "")
        loadingLabel.textAlignment = .left
        loadingLabel.font = .systemFont(ofSize: 14)
        loadingLabel.textColor = .black
        loadingLabel.numberOfLines = 0
        
        activityIndicationView.color = .black
    }
}
