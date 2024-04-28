//
//  UserRepositoryTests.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import Domain
import XCTest
@testable import Data

final class UserRepositoryTests: XCTestCase {

    // MARK: - Subject under test
    var repository: UserRepositoryImplementation!
    var userDetailsDataSourceMock: UserDetailsDataSourceMock!
    
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
        userDetailsDataSourceMock = UserDetailsDataSourceMock()
        repository = UserRepositoryImplementation(userDetailsDataSource: userDetailsDataSourceMock)
    }
    
    // MARK: - Tests

    func testThatAnUserIsReturned_When_GetUserDetailsIsCalled() async {
        do {
            _ = try await repository.getUserDetails(for: "name")
            XCTAssertTrue(userDetailsDataSourceMock.getUserDetailsCalled)
        } catch {
            XCTFail("Shouldn't throw an error")
        }
    }
    
    func testThatAnErrorIsThrown_When_GetUserDetailsIsCalled_And_DataSourceThrowsAnError() async {
        userDetailsDataSourceMock.getUserDetailsError = NetworkError(errorCode: .badGateway, errorMessage: "error")

        do {
            _ = try await repository.getUserDetails(for: "name")
            XCTFail("Should throw an error")
        } catch {
            XCTAssertTrue(error is CustomError)
        }
    }
}

class UserDetailsDataSourceMock: UserDetailsDataSource {
    
    var getUserDetailsCalled = false
    var getUserDetailsResponse: UserDetailsDTO = UserDetailsDTO(username: "test", avatar: "test")
    var getUserDetailsError: NetworkError?

    func getUserDetails(username: String) async throws -> UserDetailsDTO {
        getUserDetailsCalled = true
        if let getUserDetailsError {
            throw getUserDetailsError
        }
        return getUserDetailsResponse
    }
}

