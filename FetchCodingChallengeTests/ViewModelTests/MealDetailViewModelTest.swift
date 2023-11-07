//
//  MealDetailViewModelTest.swift
//  FetchCodingChallengeTests
//
//  Created by Jack Belding on 11/6/23.
//

import XCTest
@testable import FetchCodingChallenge

class MealDetailViewModelTests: XCTestCase {
    
    var viewModel: MealDetailViewModel!
    var mockRepository: MealRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        // Here you would initialize your viewModel with a mock repository or other necessary mocks
        mockRepository = MockMealRepository()
        let mockMealDetail = MockMealDetail(
            idMeal: "1",
            strMeal: "Mock Meal Detail",
            strInstructions: "Some instructions",
            strMealThumb: "MockDetailThumbURL",
            strTags: "Tag1,Tag2",
            strYoutube: "MockYoutubeURL",
            strSource: "MockSourceURL",
            ingredients: ["Ingredient1": "1 cup", "Ingredient2": "2 tsp"]
        ) // Initialize with required properties
        viewModel = MealDetailViewModel(mealDetail: mockMealDetail)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testOpenLinkSuccess() {
        // Given
        let url = "https://example.com"
        
        // When
        viewModel.openLink(url)
        
        // Then
        XCTAssertNil(viewModel.error, "Opening a link should not produce an error")
    }
    
    func testOpenLinkFailure() {
        // Given
        let url = "" // An invalid URL
        
        // When
        viewModel.openLink(url)
        
        // Then
        XCTAssertNotNil(viewModel.error, "Opening an invalid link should produce an error")
    }
    
    // Additional tests can be written to cover other functionalities like handling user interactions, etc.
}
