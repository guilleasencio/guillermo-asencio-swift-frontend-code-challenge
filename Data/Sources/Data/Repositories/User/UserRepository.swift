//
//  UserRepository.swift
//
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import Domain
import Foundation

class UserRepositoryImplementation: UserRepository {
    private let userDetailsDataSource: UserDetailsDataSource

    init(userDetailsDataSource: UserDetailsDataSource) {
        self.userDetailsDataSource = userDetailsDataSource
    }

    func getUserDetails(for username: String) async throws -> User {
        do {
            let userDetailsDto = try await userDetailsDataSource.getUserDetails(username: username)
            return userDetailsDto.toDomain()
        } catch let error as NetworkError {
            switch error.errorCode {
            case .notFound:
                throw CustomError(errorCode: .userNotFound, errorMessage: "User not found. Please enter another name.")
            case .networkError:
                throw CustomError(errorCode: .networkError, errorMessage: error.errorMessage)
            default:
                throw CustomError(errorCode: .generic, errorMessage: error.errorMessage)
            }
        }
    }
}

private extension UserDetailsDTO {
    func toDomain() -> User {
        User(username: username, avatar: avatar ?? "")
    }
}
