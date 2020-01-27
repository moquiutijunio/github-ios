//
//  PullToRefresh+UIScrollView.swift
//  Github API
//
//  Created by Junio Moquiuti on 26/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import Cartography
import INSPullToRefresh

extension UIScrollView {
        
    func addInfinityScrollRefreshView(handler: @escaping (UIScrollView) -> Void) {
        
        let infinityScrollRefreshView = InfinityScrollRefreshView.instantiateFromNib()
        ins_addInfinityScroll(withHeight: infinityScrollRefreshView.frame.height) { [weak self] (scrollView) -> Void in
            guard let self = self else { return }
            handler(self)
        }
        
        ins_infiniteScrollBackgroundView.delegate = infinityScrollRefreshView
        ins_infiniteScrollBackgroundView.addSubview(infinityScrollRefreshView)
        constrain(ins_infiniteScrollBackgroundView, infinityScrollRefreshView) { (infiniteScrollBackgroundView, infinityScrollRefreshView) -> () in
            infinityScrollRefreshView.edges == infiniteScrollBackgroundView.edges
        }
    }
}
