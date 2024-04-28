//
//  GetUserRepositoriesUseCaseTests.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import XCTest
@testable import Domain

final class GetUserRepositoriesUseCaseTests: XCTestCase {

    // MARK: - Subject under test
    var useCase: GetUserRepositoriesUseCaseImplementation!
    var repositoriesRepositoryMock: RepositoriesRepositoryMock!
    
    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupUseCase()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupUseCase() {
        repositoriesRepositoryMock = RepositoriesRepositoryMock()
        useCase = GetUserRepositoriesUseCaseImplementation(repositoriesRepository: repositoriesRepositoryMock)
    }

    // MARK: - Tests

    func testThatAnArrayOfRepositoriesIsReturned_When_UseCaseIsCalled() async {
        do {
            _ = try await useCase(username: "name")
            XCTAssertTrue(repositoriesRepositoryMock.getUserRepositoriesCalled)
        } catch {
            XCTFail("Shouldn't throw an error")
        }
    }
    
    func testThatAnErrorIsThrown_When_UseCaseIsCalled_And_GetUserRepositoriesThrowsAnError() async {
        repositoriesRepositoryMock.getUserRepositoriesError = CustomError(errorCode: .generic, errorMessage: "test")

        do {
            _ = try await useCase(username: "name")
            XCTFail("Should throw an error")
        } catch {
            XCTAssertTrue(error is CustomError)
        }
    }
}

class RepositoriesRepositoryMock: RepositoriesRepository {

    var getUserRepositoriesCalled = false
    var getUserRepositoriesResponse: [Repository] = [Repository(name: "repo1", language: "Swift")]
    var getUserRepositoriesError: CustomError?

    func getUserRepositories(for username: String) async throws -> [Repository] {
        getUserRepositoriesCalled = true
        if let getUserRepositoriesError {
            throw getUserRepositoriesError
        }
        return getUserRepositoriesResponse
    }
}
