//
//  GetUserDetailsUseCaseTests.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import XCTest
@testable import Domain

final class GetUserDetailsUseCaseTests: XCTestCase {

    // MARK: - Subject under test
    var useCase: GetUserDetailsUseCaseImplementation!
    var userRepositoryMock: UserRepositoryMock!
    
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
        userRepositoryMock = UserRepositoryMock()
        useCase = GetUserDetailsUseCaseImplementation(userRepository: userRepositoryMock)
    }

    // MARK: - Tests

    func testThatAnUserIsReturned_When_UseCaseIsCalled() async {
        do {
            _ = try await useCase(username: "name")
            XCTAssertTrue(userRepositoryMock.getUserDetailsCalled)
        } catch {
            XCTFail("Shouldn't throw an error")
        }
    }
    
    func testThatAnErrorIsThrown_When_UseCaseIsCalled_And_UsernameIsEmpty() async {
        do {
            _ = try await useCase(username: "")
            XCTFail("Should throw an error")
        } catch {
            XCTAssertTrue(error is CustomError)
        }
    }
    
    func testThatAnErrorIsThrown_When_UseCaseIsCalled_And_GetUserDetailsThrowsAnError() async {
        userRepositoryMock.getUserDetailsError = CustomError(errorCode: .generic, errorMessage: "test")

        do {
            _ = try await useCase(username: "name")
            XCTFail("Should throw an error")
        } catch {
            XCTAssertTrue(error is CustomError)
        }
    }
}

class UserRepositoryMock: UserRepository {

    var getUserDetailsCalled = false
    var getUserDetailsResponse: User = User(username: "test", avatar: "test")
    var getUserDetailsError: CustomError?

    func getUserDetails(for username: String) async throws -> User {
        getUserDetailsCalled = true
        if let getUserDetailsError {
            throw getUserDetailsError
        }
        return getUserDetailsResponse
    }
}
