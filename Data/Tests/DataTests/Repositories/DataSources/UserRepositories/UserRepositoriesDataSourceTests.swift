//
//  UserRepositoriesDataSourceTests.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 29/4/24.
//

import XCTest
@testable import Data

final class UserRepositoriesDataSourceTests: XCTestCase {

    // MARK: - Subject under test
    var dataSource: UserRepositoriesDataSourceImplementation!
    var networkManagerMock: NetworkManagerMock!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupDataSource()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupDataSource() {
        networkManagerMock = NetworkManagerMock()
        dataSource = UserRepositoriesDataSourceImplementation(networkManager: networkManagerMock)
    }
    
    // MARK: - Tests
    
    func testThatAnArrayOfUserRepositoryDTOsIsReturned_When_GetUserRepositoriesIsCalled() async {
        let json = """
        [
            {
                "name": "repo1",
                "language": "Swift"
            },
            {
                "name": "repo2",
                "language": "Swift"
            },
        ]
        """
        networkManagerMock.requestResponse = Data(json.utf8)

        do {
            let result = try await dataSource.getUserRepositories(username: "name")
            XCTAssertTrue(networkManagerMock.requestCalled)
            XCTAssertEqual(2, result.count)
            XCTAssertEqual("repo1", result[0].name)
            XCTAssertEqual("Swift", result[0].language)
            XCTAssertEqual("repo2", result[1].name)
            XCTAssertEqual("Swift", result[1].language)
        } catch {
            XCTFail("Shouldn't throw an error")
        }
    }
    
    func testThatAnErrorIsThrown_When_GetUserRepositoriesIsCalled_And_NetworkManagerThrowsAnError() async {
        networkManagerMock.requestError = NetworkError(errorCode: .badGateway, errorMessage: "error")
        
        do {
            _ = try await dataSource.getUserRepositories(username: "name")
            XCTFail("Should throw an error")
        } catch {
            XCTAssertTrue(networkManagerMock.requestCalled)
            XCTAssertTrue(error is NetworkError)
        }
    }
    
    func testThatAnErrorIsThrown_When_GetUserRepositoriesIsCalled_And_NetworkParserThrowsAnError() async {
        let json = """
        [
            {
                "language": "Swift"
            }
        ]
        """
        networkManagerMock.requestResponse = Data(json.utf8)
        
        do {
            _ = try await dataSource.getUserRepositories(username: "name")
            XCTFail("Should throw an error")
        } catch let error as NetworkError{
            XCTAssertTrue(networkManagerMock.requestCalled)
            XCTAssertEqual(.parseError, error.errorCode)
        } catch {
            XCTFail("Should throw an NetworkError")
        }
    }
}
