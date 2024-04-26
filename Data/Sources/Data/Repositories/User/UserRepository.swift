//
//  UserRepository.swift
//
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//
import Domain
import Foundation

class UserRepositoryImplementation: UserRepository {
    func getUserDetails(for username: String) async throws -> User {
        User(username: "guilleasencio", avatar: "https://avatars.githubusercontent.com/u/6370777?v=4")
    }
}
