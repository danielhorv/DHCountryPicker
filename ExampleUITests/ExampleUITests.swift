//
//  ExampleUITests.swift
//  ExampleUITests
//
//  Created by Daniel Horvath on 05.01.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import XCTest

class ExampleUITests: XCTestCase {

    private struct Identifier {
        static let showPickerButton = "Show CountryPicker"
        static let tableIndex = "table index"
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.launch()
        app.buttons[Identifier.showPickerButton].tap()
        app.tables.otherElements[Identifier.tableIndex].swipeDown()
        
        app.children(matching: .window)
            .element(boundBy: 0)
            .children(matching: .other)
            .element
            .swipeUp()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
