//
//  RepositoriesRepository.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Domain
import Foundation

class RepositoriesRepositoryImplementation: RepositoriesRepository {
    private let userRepositoriesDataSource: UserRepositoriesDataSource

    init(userRepositoriesDataSource: UserRepositoriesDataSource) {
        self.userRepositoriesDataSource = userRepositoriesDataSource
    }

    func getUserRepositories(for username: String) async throws -> [Repository] {
        do {
            let userRepositoriesDto = try await userRepositoriesDataSource.getUserRepositories(username: username)
            return userRepositoriesDto.map({ $0.toDomain() })
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

private extension UserRepositoryDTO {
    func toDomain() -> Repository {
        Repository(name: name, language: language)
    }
}
