//
//  RepositoriesRepositoryTests.swift
//
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import Domain
import XCTest
@testable import Data

final class RepositoriesRepositoryTests: XCTestCase {
    
    // MARK: - Subject under test
    var repository: RepositoriesRepositoryImplementation!
    var userRepositoriesDataSourceMock: UserRepositoriesDataSourceMock!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupRepository()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupRepository() {
        userRepositoriesDataSourceMock = UserRepositoriesDataSourceMock()
        repository = RepositoriesRepositoryImplementation(userRepositoriesDataSource: userRepositoriesDataSourceMock)
    }
    
    // MARK: - Tests
    
    func testThatAnUserIsReturned_When_GetUserRepositoriesIsCalled() async {
        do {
            _ = try await repository.getUserRepositories(for: "name")
            XCTAssertTrue(userRepositoriesDataSourceMock.getUserRepositoriesCalled)
        } catch {
            XCTFail("Shouldn't throw an error")
        }
    }
    
    func testThatAnErrorIsThrown_When_GetUserRepositoriesIsCalled_And_DataSourceThrowsAnError() async {
        userRepositoriesDataSourceMock.getUserRepositoriesError = NetworkError(errorCode: .badGateway,
                                                                               errorMessage: "error")
        
        do {
            _ = try await repository.getUserRepositories(for: "name")
            XCTFail("Should throw an error")
        } catch {
            XCTAssertTrue(error is CustomError)
        }
    }
}

class UserRepositoriesDataSourceMock: UserRepositoriesDataSource {

    var getUserRepositoriesCalled = false
    var getUserRepositoriesResponse: [UserRepositoryDTO] = [UserRepositoryDTO(name: "repo1", language: "Swift")]
    var getUserRepositoriesError: NetworkError?
    
    func getUserRepositories(username: String) async throws -> [UserRepositoryDTO] {
        getUserRepositoriesCalled = true
        if let getUserRepositoriesError {
            throw getUserRepositoriesError
        }
        return getUserRepositoriesResponse
    }
}

