//
//  ModelTests.swift
//  FetchCodingChallengeTests
//
//  Created by Jack Belding on 11/4/23.
//

import XCTest
@testable import FetchCodingChallenge

class ModelTests: XCTestCase {
    
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
            "ingredients": [
                {"name": "Test Ingredient 1", "measurement": "1 cup"},
                {"name": "Test Ingredient 2", "measurement": "2 tsp"}
            ]
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
            XCTAssertEqual(mealDetail.ingredients?[0].name, "Test Ingredient 1")
            XCTAssertEqual(mealDetail.ingredients?[0].measurement, "1 cup")
            XCTAssertEqual(mealDetail.ingredients?[1].name, "Test Ingredient 2")
            XCTAssertEqual(mealDetail.ingredients?[1].measurement, "2 tsp")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }

    func testIngredientDecoding() {
        let json = """
        {
            "name": "Test Ingredient",
            "measurement": "1 cup"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            let ingredient = try decoder.decode(Ingredient.self, from: json)
            XCTAssertEqual(ingredient.name, "Test Ingredient")
            XCTAssertEqual(ingredient.measurement, "1 cup")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
