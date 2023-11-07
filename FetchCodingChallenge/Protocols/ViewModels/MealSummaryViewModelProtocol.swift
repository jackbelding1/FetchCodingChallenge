//
//  MealSummaryViewModelProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

protocol MealSummaryViewModelProtocol: AnyObject {
    var mealSummaries: [any MealSummaryProtocol] { get set }
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
    var mealDetail: (any MealDetailProtocol)? { get }
    
    func fetchMealSummaries()
    func fetchMealDetail(forId id: String)
}
