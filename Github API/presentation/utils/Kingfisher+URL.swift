//
//  Kingfisher+URL.swift
//  Github API
//
//  Created by Junio Moquiuti on 26/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import Kingfisher

extension URL {
    
    func generateImage(completion: @escaping (UIImage?) -> ()) {
        UIImageView().kf.setImage(with: self) { (result) in
            if case .success(let value) = result {
                completion(value.image)
            }
        }
    }
}
