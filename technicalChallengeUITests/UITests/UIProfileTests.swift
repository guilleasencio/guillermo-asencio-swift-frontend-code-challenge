//
//  UIProfileTests.swift
//  technicalChallengeUITests
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import XCTest

final class UIProfileTests: UIBaseTest {
    
    func testProfileIsPresentedCorrectly() throws {
        app.launch()

        // Check Home Components
        let searchTextField = app.textFields["searchTextField"]
        assertElementExists(searchTextField)
        
        let searchButton = app.buttons["searchButton"]
        assertElementExists(searchButton)
        
        searchTextField.clearAndTypeText("guilleasencio")
        searchButton.tap()
        
        // Chech Profile Components
        assertElementExists(app.otherElements["profileHeaderView"])
        assertElementExists(app.tables["repositoriesTableView"])
    }
}
