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
    private let repositoriesRepository: RepositoriesRepository

    init(repositoriesRepository: RepositoriesRepository) {
        self.repositoriesRepository = repositoriesRepository
    }

    func callAsFunction(username: String) async throws -> [Repository] {
        try await repositoriesRepository.getUserRepositories(for: username)
    }
}
