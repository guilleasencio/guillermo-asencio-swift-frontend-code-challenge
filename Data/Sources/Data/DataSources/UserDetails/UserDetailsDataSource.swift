//
//  UserDetailsDataSource.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

protocol UserDetailsDataSource: AnyObject {
    func getUserDetails(username: String) async throws -> UserDetailsDTO
}

class UserDetailsDataSourceImplementation: UserDetailsDataSource {
    private let networkManager: NetworkManagerLogic

    init(networkManager: NetworkManagerLogic) {
        self.networkManager = networkManager
    }

    func getUserDetails(username: String) async throws -> UserDetailsDTO {
        let request = UserDetailsRequest(username: username)
        let data = try await networkManager.request(request)
        return try NetworkParser.parse(data: data, entityType: UserDetailsDTO.self)
    }
}
