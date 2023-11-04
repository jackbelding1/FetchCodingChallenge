//
//  MealSummary.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/4/23.
//

import Foundation
struct MealSummary: MealSummaryProtocol, Codable {
    let idMeal: String
    let strMeal: String?
    let strMealThumb: String?
    
    var id: String {
        return idMeal
    }
}
