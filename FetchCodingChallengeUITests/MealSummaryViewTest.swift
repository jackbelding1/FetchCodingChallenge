//
//  MealSummaryViewTest.swift
//  FetchCodingChallengeUITests
//
//  Created by Jack Belding on 11/8/23.
//

import XCTest

final class MealSummaryViewTest: XCTestCase {

    func testMealSummaryGridItemDisplay() {
        let app = XCUIApplication()
        app.launch()
        print(app.debugDescription)

        // Access the grid
        let grid = app.otherElements["mealSummaryGrid"]

        // Wait for the grid to exist with a timeout
        let gridExists = grid.waitForExistence(timeout: 10)
        XCTAssertTrue(gridExists, "The meal summary grid should exist.")

        // Assuming each meal summary item has a unique accessibility identifier
        let firstItem = grid.buttons.element(boundBy: 0)
        XCTAssertTrue(firstItem.exists, "The first meal summary item should be displayed.")
        XCTAssertTrue(firstItem.staticTexts.count > 0, "The meal summary item should have text.")
        XCTAssertTrue(firstItem.images.count > 0, "The meal summary item should have an image.")
    }

}
