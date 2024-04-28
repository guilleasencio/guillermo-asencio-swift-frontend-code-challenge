//
//  UserRepositoriesDataSource.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

protocol UserRepositoriesDataSource: AnyObject {
    func getUserRepositories(username: String) async throws -> [UserRepositoryDTO]
}

class UserRepositoriesDataSourceImplementation: UserRepositoriesDataSource {
    private let networkManager: NetworkManagerLogic

    init(networkManager: NetworkManagerLogic) {
        self.networkManager = networkManager
    }

    func getUserRepositories(username: String) async throws -> [UserRepositoryDTO] {
        let request = UserRepositoriesRequest(username: username)
        let data = try await networkManager.request(request)
        return try NetworkParser.parse(data: data, entityType: [UserRepositoryDTO].self)
    }
}
