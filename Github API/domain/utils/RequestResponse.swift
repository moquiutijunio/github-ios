//
//  RequestResponse.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

enum RequestResponse<T> {
    
    case new
    case loading
    case success(T)
    case failure(Error)
}
