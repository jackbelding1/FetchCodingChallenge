//
//  MealRepositoryProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

protocol MealRepositoryProtocol {
    func fetchMealSummaries(completion: @escaping (Result<[MealSummary], Error>) -> Void)
    func fetchMealDetail(forId id: String, completion: @escaping (Result<MealDetail, Error>) -> Void)
}
