//
//  ModelTests.swift
//  FetchCodingChallengeTests
//
//  Created by Jack Belding on 11/4/23.
//

import XCTest
@testable import FetchCodingChallenge

class ModelTests: XCTestCase {
    
    // Test MealSummary Decoding
    func testMealSummaryDecoding() {
        let json = """
        {
            "idMeal": "12345",
            "strMeal": "Test Meal",
            "strMealThumb": "https://example.com/image.jpg"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            let mealSummary = try decoder.decode(MealSummary.self, from: json)
            XCTAssertEqual(mealSummary.idMeal, "12345")
            XCTAssertEqual(mealSummary.strMeal, "Test Meal")
            XCTAssertEqual(mealSummary.strMealThumb, "https://example.com/image.jpg")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }

    // Test MealDetail Decoding
    func testMealDetailDecoding() {
        let json = """
        {
            "idMeal": "12345",
            "strMeal": "Test Meal",
            "strInstructions": "Test Instructions",
            "strMealThumb": "https://example.com/image.jpg",
            "strTags": "Test,Tags",
            "strYoutube": "https://youtube.com",
            "strSource": "https://source.com",
            "ingredients": {
                "Test Ingredient 1": "1 cup",
                "Test Ingredient 2": "2 tsp"
            }
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            let mealDetail = try decoder.decode(MealDetail.self, from: json)
            XCTAssertEqual(mealDetail.idMeal, "12345")
            XCTAssertEqual(mealDetail.strMeal, "Test Meal")
            XCTAssertEqual(mealDetail.strInstructions, "Test Instructions")
            XCTAssertEqual(mealDetail.strMealThumb, "https://example.com/image.jpg")
            XCTAssertEqual(mealDetail.strTags, "Test,Tags")
            XCTAssertEqual(mealDetail.strYoutube, "https://youtube.com")
            XCTAssertEqual(mealDetail.strSource, "https://source.com")
            XCTAssertEqual(mealDetail.ingredients?.count, 2)
            XCTAssertEqual(mealDetail.ingredients?["Test Ingredient 1"], "1 cup")
            XCTAssertEqual(mealDetail.ingredients?["Test Ingredient 2"], "2 tsp")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }

}
