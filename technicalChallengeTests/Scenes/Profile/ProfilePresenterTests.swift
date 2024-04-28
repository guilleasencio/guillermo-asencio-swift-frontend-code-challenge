//
//  ProfilePresenterTests.swift
//  technicalChallengeTests
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import Domain
import XCTest
@testable import technicalChallenge

final class ProfilePresenterTests: XCTestCase {

    // MARK: - Subject under test
    var presenter: ProfilePresenter!
    var viewControllerMock: ProfileDisplayLogicMock!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupPresenter() {
        viewControllerMock = ProfileDisplayLogicMock()
        presenter = ProfilePresenter()
        presenter.viewController = viewControllerMock
    }

    // MARK: - Tests

    func testThatDisplayDataIsCalled_When_PresentUserDetailsIsCalled_And_ResponseStateIsSuccess() async {
        // Given
        let user = User(username: "test", avatar: "test")
        let repositories = [Repository(name: "test", language: nil)]
        let response = Profile.Data.Response(state: .success(user: user, repositories: repositories))

        // When
        presenter.presentData(response: response)
    
        // Then
        XCTAssertTrue(viewControllerMock.displayDataCalled)
    }

    func testThatDisplayDataIsCalled_When_PresentUserDetailsIsCalled_And_ResponseStateIsError() async {
        // Given
        let response = Profile.Data.Response(state: .error(message: "message"))

        // When
        presenter.presentData(response: response)
    
        // Then
        XCTAssertTrue(viewControllerMock.displayDataCalled)
    }
}

// MARK: - Mocks

class ProfileDisplayLogicMock: ProfileDisplayLogic {

    var displayDataCalled = false

    func displayData(viewModel: Profile.Data.ViewModel) {
        displayDataCalled = true
    }
}

