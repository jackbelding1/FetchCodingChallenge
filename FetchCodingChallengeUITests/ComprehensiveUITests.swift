//
//  MealSummaryViewTest.swift
//  FetchCodingChallengeUITests
//
//  Created by Jack Belding on 11/8/23.
//

import XCTest

final class ComprehensiveUITests: XCTestCase {
    
    // MARK: - Meal Summary Grid Display Tests

    func testMealSummaryGridItemDisplay() {
        let app = XCUIApplication()
        app.launch()

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
    
    // MARK: - Navigation to Meal Detail View Tests

    func testNavigationToMealDetailView() {
        let app = XCUIApplication()
        app.launch()

        let grid = app.otherElements["mealSummaryGrid"]
        XCTAssertTrue(grid.waitForExistence(timeout: 10), "Meal summary grid did not appear in time")

        let firstItem = grid.buttons.element(boundBy: 0)
        XCTAssertTrue(firstItem.exists, "The first meal summary item is not displayed")
        firstItem.tap()
        
        // Assert Meal detail is showing
        XCTAssertTrue(app.staticTexts["mealDetailTitle"].exists, "The meal title should be displayed")
        XCTAssertTrue(app.images["mealDetailImageView"].exists, "The meal image should be displayed")
        XCTAssertTrue(app.staticTexts["mealDetailIngredientsView"].exists, "The ingredients view should be present")
        XCTAssertTrue(app.staticTexts["mealDetailInstructionsView"].exists, "The instructions view should be displayed")
        XCTAssertTrue(app.buttons["mealDetailAdditionalInfoView"].exists, "The additional info view should be present")
    }
    
    // MARK: - Navigation Back from Meal Detail View Tests
    
    func testNavigateBackFromMealDetailView() {
        let app = XCUIApplication()
        app.launch()

        let grid = app.otherElements["mealSummaryGrid"]
        XCTAssertTrue(grid.waitForExistence(timeout: 10), "Meal summary grid did not appear in time")

        let firstItem = grid.buttons.element(boundBy: 0)
        XCTAssertTrue(firstItem.exists, "The first meal summary item is not displayed")
        firstItem.tap()
        print(app.debugDescription)
        XCTAssertTrue(app.staticTexts["mealDetailTitle"].exists, "The meal title should be displayed")
        
        let backButton = app.buttons["Back"]
        XCTAssertTrue(backButton.exists, "The back button is not displayed")
        backButton.tap()

        // Assert Popup is gone
        XCTAssertFalse(backButton.exists, "The back button displays")
        
    }
}
