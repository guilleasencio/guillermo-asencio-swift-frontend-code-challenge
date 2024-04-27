//
//  GetUserRepositoriesUseCase.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

public protocol GetUserRepositoriesUseCase: AnyObject {
    func callAsFunction(username: String) async throws -> [Repository]
}

final class GetUserRepositoriesUseCaseImplementation: GetUserRepositoriesUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func callAsFunction(username: String) async throws -> [Repository] {
        return try await userRepository.getUserRepositories(for: username)
    }
}
