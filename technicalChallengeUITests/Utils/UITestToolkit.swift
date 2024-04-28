//
//  UITestToolkit.swift
//  technicalChallengeUITests
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import XCTest

func assertElementExists(_ element: XCUIElement, until waitingTime: Int = 30) {
    let exists = element.waitUntilVisible(waitingTime)
    XCTAssertTrue(exists)
}
