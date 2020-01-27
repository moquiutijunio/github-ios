//
//  BaseInteractor.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

class BaseInteractor {
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}
