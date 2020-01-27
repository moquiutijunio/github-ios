//
//  InfinityScrollRefreshView.swift
//  Github API
//
//  Created by Junio Moquiuti on 26/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import INSPullToRefresh

final class InfinityScrollRefreshView: UIView {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicatorView.color = .black
    }
}

// MARK: - INSInfiniteScrollBackgroundViewDelegate
extension InfinityScrollRefreshView: INSInfiniteScrollBackgroundViewDelegate {
    
    func infinityScrollBackgroundView(_ infinityScrollBackgroundView: INSInfiniteScrollBackgroundView!, didChange state: INSInfiniteScrollBackgroundViewState) {
        
        switch state {
        case .none:
            activityIndicatorView.stopAnimating()
            
        case .loading:
            activityIndicatorView.startAnimating()
            
        default:
            break
        }
    }
}

// MARK: - UINib
extension InfinityScrollRefreshView {
        
    class func instantiateFromNib() -> InfinityScrollRefreshView {
        return UINib(nibName: "InfinityScrollRefreshView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! InfinityScrollRefreshView
    }
}
