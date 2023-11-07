//
//  MockMealSummaryViewModel.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation
@testable import FetchCodingChallenge

class MockMealSummaryViewModel: MealSummaryViewModelProtocol {
    
    // MARK: - Properties for Mock
    
    var mealSummaries: [any MealSummaryProtocol] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var mealDetail: (any MealDetailProtocol)?
    
    // Flags to control mock behavior
    var shouldReturnErrorOnFetchSummaries: Bool = false
    var shouldReturnErrorOnFetchDetail: Bool = false
    
    // MARK: - Initialization
    
    init() {
        // You can initialize with default values or specific test data if required
    }
    
    // MARK: - Mock Methods
    
    func fetchMealSummaries() {
        isLoading = true
        if shouldReturnErrorOnFetchSummaries {
            errorMessage = "Mock error: failed to fetch meal summaries"
            isLoading = false
        } else {
            // Provide mock data for meal summaries
            let mockSummary = MockMealSummary(idMeal: "1", strMeal: "Mock Meal", strMealThumb: "mockThumbURL")
            mealSummaries = [mockSummary]
            isLoading = false
        }
    }
    
    func fetchMealDetail(forId id: String) {
        isLoading = true
        if shouldReturnErrorOnFetchDetail {
            errorMessage = "Mock error: failed to fetch meal detail"
            isLoading = false
        } else {
            // Provide mock data for meal detail
            let mockDetail = MockMealDetail(idMeal: id, strMeal: "Mock Meal", strInstructions: "Mock Instructions", strMealThumb: "mockThumbURL", strTags: "Mock Tags", strYoutube: "mockYoutubeURL", strSource: "mockSourceURL", ingredients: ["Ingredient1": "1 cup"])
            mealDetail = mockDetail
            isLoading = false
        }
    }
    
    // MARK: - Helper Methods
    
    // You can add helper methods to modify mock behavior during tests, like resetting mock state or setting specific flags.
}
