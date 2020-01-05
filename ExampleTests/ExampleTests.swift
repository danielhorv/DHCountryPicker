//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Daniel Horvath on 05.01.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import XCTest
import DHCountryPicker

class ExampleTests: XCTestCase {
    private let countryProvider = DHCountryProvider()

    func testCurrentCountry() {
        if let current = countryProvider.current {
            print("My current country is: \(current.localizedName)")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
