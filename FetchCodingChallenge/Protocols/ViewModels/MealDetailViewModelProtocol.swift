//
//  MealDetailViewModelProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

// MARK: - Meal Detail View Model Protocol

protocol MealDetailViewModelProtocol: AnyObject {
    
    // MARK: - Properties

    var mealDetail: (any MealDetailProtocol)? { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    // MARK: - Methods
    
    func loadMealDetail()
}
