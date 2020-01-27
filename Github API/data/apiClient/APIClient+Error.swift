//
//  APIClient+Error.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation

extension APIClient {
    
    static let errorDomain = "APIClient"
    static func error(description: String, code: Int = 0) -> NSError {

        return NSError(domain: errorDomain,
                       code: code,
                       userInfo: [NSLocalizedDescriptionKey: description])
    }
}
