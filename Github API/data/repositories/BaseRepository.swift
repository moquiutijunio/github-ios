//
//  BaseRepository.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

class BaseRepository {
    
    internal let apiClient: APIClientProtocol
    
    init() {
        self.apiClient = APIClient()
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}
