//
//  MealRepositoryProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

protocol MealRepositoryProtocol {
    func fetchMealSummaries(completion: @escaping (Result<[any MealSummaryProtocol], Error>) -> Void)
    func fetchMealDetail(forId id: String, completion: @escaping (Result<any MealDetailProtocol, Error>) -> Void)
}
