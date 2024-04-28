//
//  HomeInteractorTests.swift
//  technicalChallengeTests
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import Domain
import XCTest
@testable import technicalChallenge

final class HomeInteractorTests: XCTestCase {

    // MARK: - Subject under test
    var interactor: HomeInteractor!
    var presenterMock: HomePresentationLogicMock!
    var getUserDetailsUseCaseMock: GetUserDetailsUseCaseMock!

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
        getUserDetailsUseCaseMock = GetUserDetailsUseCaseMock()
        presenterMock = HomePresentationLogicMock()
        interactor = HomeInteractor(getUserDetailsUseCase: getUserDetailsUseCaseMock)
        interactor.presenter = presenterMock
    }
    
    // MARK: - Tests

    func testThatPresentUserDetailsIsCalled_When_DoGetUserDetailsIsCalled_And_GetUserDetailsUseCaseReturnsAnUser() async {
        // Given
        let request = Home.UserDetails.Request(term: "test")

        // When
       
        interactor.doGetUserDetails(request: request)
        await interactor.tasks.awaitAll()
    
        // Then
        XCTAssertTrue(getUserDetailsUseCaseMock.callAsFunctionCalled)
        XCTAssertTrue(presenterMock.presentUserDetailsCalled)
    }
    
    func testThatPresentUserDetailsIsCalled_When_DoGetUserDetailsIsCalled_And_GetUserDetailsUseCaseReturnsAnError() async {
        // Given
        getUserDetailsUseCaseMock.callAsFunctionError = CustomError(errorCode: .generic, errorMessage: "test")
        let request = Home.UserDetails.Request(term: "test")

        // When
       
        interactor.doGetUserDetails(request: request)
        await interactor.tasks.awaitAll()
    
        // Then
        XCTAssertTrue(getUserDetailsUseCaseMock.callAsFunctionCalled)
        XCTAssertTrue(presenterMock.presentUserDetailsCalled)
    }
}

// MARK: - Mocks

class HomePresentationLogicMock: HomePresentationLogic {

    var presentUserDetailsCalled = false

    func presentUserDetails(response: Home.UserDetails.Response) {
        presentUserDetailsCalled = true
    }
}

class GetUserDetailsUseCaseMock: GetUserDetailsUseCase {

    var callAsFunctionCalled = false
    var callAsFunctionResponse: User = User(username: "test", avatar: "test")
    var callAsFunctionError: CustomError?

    func callAsFunction(username: String) async throws -> User {
        callAsFunctionCalled = true
        if let callAsFunctionError {
            throw callAsFunctionError
        }
        return callAsFunctionResponse
    }
}
