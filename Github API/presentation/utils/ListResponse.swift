//
//  ListResponse.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

enum ListResponse<T> {
    
    case new
    case loading
    case success(T, infinityScrollIsEnabled: Bool? = nil)
    case failure(String)
}
