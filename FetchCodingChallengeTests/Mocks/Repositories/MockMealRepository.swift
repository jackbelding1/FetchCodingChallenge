//
//  MockMealRepository.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation
@testable import FetchCodingChallenge

// MARK: - Mock Meal Repository

class MockMealRepository: MealRepositoryProtocol {
    
    // MARK: - Properties
    
    var shouldReturnSuccess: Bool = true
    var mockMealSummaries: [MockMealSummary] = []
    
    // MARK: - Methods
    
    func fetchMealSummaries(completion: @escaping (Result<[any MealSummaryProtocol], Error>) -> Void) {
        if shouldReturnSuccess {
            completion(.success(mockMealSummaries as [any MealSummaryProtocol]))
        } else {
            // Hardcoded failure response
            completion(.failure(NSError(domain: "com.example.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch meal summaries."])))
        }
    }
    
    func fetchMealDetail(forId id: String, completion: @escaping (Result<any MealDetailProtocol, Error>) -> Void) {
        if shouldReturnSuccess {
            // Hardcoded successful response using the mock models
            // Provide mock data for meal detail
            let mockIngredients = [
                Ingredient(name: "Ingredient1", measurement: "1 cup"),
                // Add more mock ingredients as needed
            ]
            
            let mockDetail = MockMealDetail(
                idMeal: id,
                strMeal: "Mock Meal",
                strInstructions: "Mock Instructions",
                strMealThumb: "mockThumbURL",
                strTags: "Mock Tags",
                strYoutube: "mockYoutubeURL",
                strSource: "mockSourceURL",
                ingredients: mockIngredients
            )
            
            completion(.success(mockDetail as any MealDetailProtocol))
        } else {
            // Hardcoded failure response
            completion(.failure(NSError(domain: "com.example.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch meal detail."])))
        }
    }
}
