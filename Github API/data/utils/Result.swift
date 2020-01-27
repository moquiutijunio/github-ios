//
//  Result.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    
    case success(T)
    case failure(E)
}
