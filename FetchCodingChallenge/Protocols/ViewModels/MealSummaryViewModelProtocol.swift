//
//  MealSummaryViewModelProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

// MARK: - Meal Summary View Model Protocol

protocol MealSummaryViewModelProtocol: AnyObject {
    
    // MARK: - Properties
    
    var mealSummaries: [any MealSummaryProtocol] { get set }
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
    var mealDetail: (any MealDetailProtocol)? { get }
    
    // MARK: - Data Fetching Methods
    
    func fetchMealSummaries()
    func fetchMealDetail(forId id: String)
}
