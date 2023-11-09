//
//  MealSummaryProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/4/23.
//

import Foundation
protocol MealSummaryProtocol: Identifiable {
    var idMeal: String { get }
    var strMeal: String? { get }
    var strMealThumb: String? { get }
    var id: String { get }
}
