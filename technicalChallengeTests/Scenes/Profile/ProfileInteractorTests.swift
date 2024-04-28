//
//  ProfileInteractorTests.swift
//  technicalChallengeTests
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import Domain
import XCTest
@testable import technicalChallenge

final class ProfileInteractorTests: XCTestCase {

    // MARK: - Subject under test
    var interactor: ProfileInteractor!
    var presenterMock: ProfilePresentationLogicMock!
    var getUserRepositoriesUseCaseMock: GetUserRepositoriesUseCaseMock!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupInteractor() {
        getUserRepositoriesUseCaseMock = GetUserRepositoriesUseCaseMock()
        presenterMock = ProfilePresentationLogicMock()
        interactor = ProfileInteractor(getUserRepositoriesUseCase: getUserRepositoriesUseCaseMock)
        interactor.presenter = presenterMock
        interactor.user = User(username: "name", avatar: "avatar")
    }

    // MARK: - Tests

    func testThatPresentUserDetailsIsCalled_When_DoGetUserDetailsIsCalled_And_GetUserDetailsUseCaseReturnsAnUser() async {
        // Given
        let request = Profile.Data.Request()

        // When

        interactor.loadData(request: request)
        await interactor.tasks.awaitAll()

        // Then
        XCTAssertTrue(getUserRepositoriesUseCaseMock.callAsFunctionCalled)
        XCTAssertTrue(presenterMock.presentDataCalled)
    }

    func testThatPresentUserDetailsIsCalled_When_DoGetUserDetailsIsCalled_And_GetUserDetailsUseCaseReturnsAnError() async {
        // Given
        getUserRepositoriesUseCaseMock.callAsFunctionError = CustomError(errorCode: .generic, errorMessage: "test")
        let request = Profile.Data.Request()

        // When

        interactor.loadData(request: request)
        await interactor.tasks.awaitAll()

        // Then
        XCTAssertTrue(getUserRepositoriesUseCaseMock.callAsFunctionCalled)
        XCTAssertTrue(presenterMock.presentDataCalled)
    }
}

// MARK: - Mocks

class ProfilePresentationLogicMock: ProfilePresentationLogic {

    var presentDataCalled = false

    func presentData(response: Profile.Data.Response) {
        presentDataCalled = true
    }
}

class GetUserRepositoriesUseCaseMock: GetUserRepositoriesUseCase {

    var callAsFunctionCalled = false
    var callAsFunctionResponse: [Repository] = [Repository(name: "repo1", language: "Swift")]
    var callAsFunctionError: CustomError?

    func callAsFunction(username: String) async throws -> [Repository] {
        callAsFunctionCalled = true
        if let callAsFunctionError {
            throw callAsFunctionError
        }
        return callAsFunctionResponse
    }
}
