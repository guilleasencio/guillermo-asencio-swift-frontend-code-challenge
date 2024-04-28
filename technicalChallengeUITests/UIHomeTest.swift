//
//  UIHomeTest.swift
//  technicalChallengeUITests
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import XCTest

final class UIHomeTest: UIBaseTest {

    func testHomeIsPresentedCorrectly() throws {
        app.launch()

        assertElementExists(app.images["imageView"])
        assertElementExists(app.textFields["searchTextField"])
        assertElementExists(app.buttons["searchButton"])
    }
}
