//
//  HomePresenterTests.swift
//  technicalChallengeTests
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import XCTest
@testable import technicalChallenge

final class HomePresenterTests: XCTestCase {
    
    // MARK: - Subject under test
    var presenter: HomePresenter!
    var viewControllerMock: HomeDisplayLogicMock!

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
        viewControllerMock = HomeDisplayLogicMock()
        presenter = HomePresenter()
        presenter.viewController = viewControllerMock
    }

    // MARK: - Tests

    func testThatDisplayUserDetailsIsCalled_When_PresentUserDetailsIsCalled() async {
        // Given
        let response = Home.UserDetails.Response(errorMessage: nil)

        // When
        presenter.presentUserDetails(response: response)
    
        // Then
        XCTAssertTrue(viewControllerMock.displayUserDetailsCalled)
    }
}

// MARK: - Mocks

class HomeDisplayLogicMock: HomeDisplayLogic {

    var displayUserDetailsCalled = false

    func displayUserDetails(viewModel: Home.UserDetails.ViewModel) {
        displayUserDetailsCalled = true
    }
}
