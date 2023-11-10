//
//  MealRepositoryProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

// MARK: - Meal Repository Protocol

protocol MealRepositoryProtocol {
    
    // MARK: - Methods
    
    func fetchMealSummaries(completion: @escaping (Result<[any MealSummaryProtocol], Error>) -> Void)
    func fetchMealDetail(forId id: String, completion: @escaping (Result<any MealDetailProtocol, Error>) -> Void)
}
