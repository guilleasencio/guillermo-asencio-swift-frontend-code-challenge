//
//  UIBaseTest.swift
//  technicalChallengeUITests
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//

import XCTest

class UIBaseTest: XCTestCase {
    var app = XCUIApplication()
    
    let defaultTimeout: Double = 60.0
    
    var timer: Timer?

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        timer = Timer.scheduledTimer(withTimeInterval: defaultTimeout, repeats: false, block: { _ in
            XCTFail("Test timeout")
        })
        
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        super.tearDown()
        
        timer?.invalidate()
        timer = nil
    }
}
