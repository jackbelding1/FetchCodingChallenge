//
//  MockMealDetail.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation
@testable import FetchCodingChallenge

// MARK: - Mock Meal Detail

class MockMealDetail: MealDetailProtocol {
    
    // MARK: - Properties

    var id: String { idMeal }
    var idMeal: String
    var strMeal: String?
    var strInstructions: String?
    var strMealThumb: String?
    var strTags: String?
    var strYoutube: String?
    var strSource: String?
    var ingredients: [Ingredient]
    
    // MARK: - Initializer

    init(idMeal: String, strMeal: String?, strInstructions: String?, strMealThumb: String?,
         strTags: String?, strYoutube: String?, strSource: String?, ingredients: [Ingredient]) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.strTags = strTags
        self.strYoutube = strYoutube
        self.strSource = strSource
        self.ingredients = ingredients
    }
}
