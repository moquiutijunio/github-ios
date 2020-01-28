//
//  Github_APITests.swift
//  Github APITests
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import XCTest
@testable import Github_API

class Github_APITests: XCTestCase {

    func testUserResult() {
    
        //Mock user result
        var userAPI = UserAPI()
        userAPI.id = 10856384
        userAPI.name = "Junio Moquiuti"
        userAPI.login = "moquiutijunio"
        userAPI.bio = "Developer iOS and organizer of CocoaHeads CG/MS."
        userAPI.publicRepos = 15
        userAPI.followers = 10
        userAPI.following = 26
        
        let result: Result<UserAPI, Error> = .success(userAPI)
        
        //Assert
        switch result {
        case .success(let userAPI):
            guard let user = User.map(user: userAPI) else {
                XCTFail("Failed to mapper userAPI")
                return
            }
            
            XCTAssertEqual(user.id, 10856384)
            XCTAssertEqual(user.name, "Junio Moquiuti")
            XCTAssertEqual(user.login, "moquiutijunio")
            XCTAssertEqual(user.bio, "Developer iOS and organizer of CocoaHeads CG/MS.")
            XCTAssertEqual(user.followers, 10)
            XCTAssertEqual(user.following, 26)
            
        case .failure(let error):
            XCTFail("Expected to succeed but failed with error \(error)")
        }
    }
    
    func testUserRepositoriesResult() {
        
        //Mock repositories result
        var repository = RepositoryAPI()
        repository.id = 100886109
        repository.name = "Jera-Labs-iOS"
        repository.description = "iOS application made to list all Labs created by Jera’s employees"
        repository.stargazersCount = 6

        let result: Result<[RepositoryAPI], Error> = .success([repository])
        
        //Assert
        if case .success(let repositoriesAPI) = result {
            let repositories = Repository.mapArray(repositories: repositoriesAPI)
            
            let repositoriesCount = repositories.count
            let repository = repositories.first
            XCTAssert(repositoriesCount == 1, "repositories count \(repositoriesCount)")
            XCTAssertEqual(repository?.id, 100886109)
            XCTAssertEqual(repository?.name, "Jera-Labs-iOS")
            XCTAssertEqual(repository?.description, "iOS application made to list all Labs created by Jera’s employees")
            XCTAssertEqual(repository?.stargazersCount, 6)
        }
    }
}
