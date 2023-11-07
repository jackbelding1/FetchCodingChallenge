//
//  MealDetailProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/4/23.
//

import Foundation
protocol MealDetailProtocol: Codable, Identifiable {
    var idMeal: String { get }
    var strMeal: String? { get }
    var strInstructions: String? { get }
    var strMealThumb: String? { get }
    var strTags: String? { get }
    var strYoutube: String? { get }
    var strSource: String? { get }
    var ingredients: [String : String]? { get }
}
