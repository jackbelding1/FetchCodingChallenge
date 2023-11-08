//
//  MealDetailViewModelProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

protocol MealDetailViewModelProtocol: AnyObject {
    var mealDetail: (any MealDetailProtocol)? { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func loadMealDetail()
}
