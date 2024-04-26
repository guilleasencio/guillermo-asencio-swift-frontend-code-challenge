//
//  GetUserDetailsUseCase.swift
//
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import Foundation

public protocol GetUserDetailsUseCase: AnyObject {
    func callAsFunction(username: String) async throws -> User
}

final class GetUserDetailsUseCaseImplementation: GetUserDetailsUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func callAsFunction(username: String) async throws -> User {
        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedUsername.isEmpty else {
            throw CustomError(errorCode: .emptyUsername, errorMessage: "Username cannot be empty")
        }

        return try await userRepository.getUserDetails(for: trimmedUsername)
    }
}
