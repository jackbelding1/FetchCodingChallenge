//
//  MealSummary.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/4/23.
//

import Foundation

// MARK: - Meal Summary

struct MealSummary: MealSummaryProtocol, Codable {
    
    // MARK: - Properties

    let idMeal: String
    let strMeal: String?
    let strMealThumb: String?
    
    // MARK: - Computed Properties
    
    var id: String {
        return idMeal
    }
}
