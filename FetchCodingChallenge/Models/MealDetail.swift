//
//  MealDetail.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/4/23.
//

import Foundation
class MealDetail: MealDetailProtocol {
    let idMeal: String
    let strMeal: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strSource: String?
    let ingredients: [String : String]?

    var id: String {
        return idMeal
    }
    
    required init(idMeal: String, strMeal: String?, strInstructions: String?, strMealThumb: String?, strTags: String?, strYoutube: String?, strSource: String?, ingredients: [String : String]?) {
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
