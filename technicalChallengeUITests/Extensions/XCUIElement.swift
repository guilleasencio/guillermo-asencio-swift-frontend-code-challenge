//
//  XCUIElement.swift
//  technicalChallengeUITests
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import XCTest

extension XCUIElement {
    
    func visible(insets: UIEdgeInsets = .zero) -> Bool {
        guard exists, !frame.isEmpty else { return false }
        var windowFrame = XCUIApplication().windows.element(boundBy: 0).frame
        windowFrame.size.height = windowFrame.size.height - insets.top - insets.bottom
        windowFrame.origin.y += insets.top
        return windowFrame.contains(frame)
    }
    
    func waitUntilVisible(_ seconds: Int = 30) -> Bool {
        if visible() {
            return true
        }
        return waitForExistence(timeout: TimeInterval(seconds))
    }
}
