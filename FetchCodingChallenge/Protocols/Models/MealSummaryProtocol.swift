//
//  MealSummaryProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/4/23.
//

import Foundation

// MARK: - Meal Summary Model Protocol

protocol MealSummaryProtocol: Identifiable {
    
    // MARK: - Properties
    
    var idMeal: String { get }
    var strMeal: String? { get }
    var strMealThumb: String? { get }
    var id: String { get }
}
