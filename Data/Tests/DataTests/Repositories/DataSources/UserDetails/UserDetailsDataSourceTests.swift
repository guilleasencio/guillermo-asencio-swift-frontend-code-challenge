//
//  UserDetailsDataSourceTests.swift
//
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import XCTest
@testable import Data

final class UserDetailsDataSourceTests: XCTestCase {

    // MARK: - Subject under test
    var dataSource: UserDetailsDataSourceImplementation!
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
        dataSource = UserDetailsDataSourceImplementation(networkManager: networkManagerMock)
    }
    
    // MARK: - Tests
    
    func testThatAnUserDetailsDTOIsReturned_When_GetUserDetailsIsCalled() async {
        let json = """
        {
            "login": "name",
            "avatar_url" : "https://avatars.githubusercontent.com/u/6370777?v=4"
        }
        """
        networkManagerMock.requestResponse = Data(json.utf8)

        do {
            let result = try await dataSource.getUserDetails(username: "name")
            XCTAssertTrue(networkManagerMock.requestCalled)
            XCTAssertEqual("name", result.username)
            XCTAssertEqual("https://avatars.githubusercontent.com/u/6370777?v=4", result.avatar)
        } catch {
            XCTFail("Shouldn't throw an error")
        }
    }
    
    func testThatAnErrorIsThrown_When_GetUserDetailsIsCalled_And_NetworkManagerThrowsAnError() async {
        networkManagerMock.requestError = NetworkError(errorCode: .badGateway, errorMessage: "error")
        
        do {
            _ = try await dataSource.getUserDetails(username: "name")
            XCTFail("Should throw an error")
        } catch {
            XCTAssertTrue(networkManagerMock.requestCalled)
            XCTAssertTrue(error is NetworkError)
        }
    }
    
    func testThatAnErrorIsThrown_When_GetUserDetailsIsCalled_And_NetworkParserThrowsAnError() async {
        let json = """
        {
            "avatar_url" : "https://avatars.githubusercontent.com/u/6370777?v=4"
        }
        """
        networkManagerMock.requestResponse = Data(json.utf8)
        
        do {
            _ = try await dataSource.getUserDetails(username: "name")
            XCTFail("Should throw an error")
        } catch let error as NetworkError{
            XCTAssertTrue(networkManagerMock.requestCalled)
            XCTAssertEqual(.parseError, error.errorCode)
        } catch {
            XCTFail("Should throw an NetworkError")
        }
    }
}
