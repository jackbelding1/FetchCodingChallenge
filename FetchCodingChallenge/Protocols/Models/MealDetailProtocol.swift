//
//  MealDetailProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/4/23.
//

import Foundation
protocol MealDetailProtocol: Decodable, Identifiable {
    var idMeal: String { get }
    var strMeal: String? { get }
    var strInstructions: String? { get }
    var strMealThumb: String? { get }
    var strTags: String? { get }
    var strYoutube: String? { get }
    var strSource: String? { get }
    var ingredients: [Ingredient] { get } // Updated to use an array of Ingredient objects
}

struct Ingredient: Decodable {
    let name: String
    let measurement: String
}
