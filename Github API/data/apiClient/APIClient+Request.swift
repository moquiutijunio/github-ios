//
//  APIClient+Request.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import Foundation

extension APIClient {
    
    internal func request(_ target: APITarget, completion: @escaping (Result<Data, Error>) -> ()) {
        
        URLSession.shared.dataTask(with: target.urlRequest) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error ?? APIClient.error(description: NSLocalizedString("generic.request.error", comment: ""))))
                return
            }

            completion(.success(data))
        }.resume()
    }
}
