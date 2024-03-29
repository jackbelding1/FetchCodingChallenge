//
//  MealDetail.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/4/23.
//

import Foundation

// MARK: - Meal Detail Model

class MealDetail: MealDetailProtocol {
    
    // MARK: - Properties
    
    let idMeal: String
    let strMeal: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strSource: String?
    var ingredients: [Ingredient] = []
    
    // MARK: - CodingKeys Enum
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb, strTags, strYoutube, strSource
        case strIngredient, strMeasure
    }
    
    // MARK: - DynamicKey Struct
    // Custom CodingKey struct for dynamic keys
    struct DynamicKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }
    
    // MARK: - Initializer
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decodeIfPresent(String.self, forKey: .strMeal)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        
        // MARK: - Ingredients Processing
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
        var seenIngredients = Set<String>()
        
        for index in 1...20 {
            let ingredientKeyString = "strIngredient\(index)"
            let measureKeyString = "strMeasure\(index)"
            
            if let ingredientKey = DynamicKey(stringValue: ingredientKeyString),
               let measureKey = DynamicKey(stringValue: measureKeyString),
               let ingredientName = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredientName.isEmpty,
               let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey) {
                
                // Check if the ingredient is already in the seenIngredients set
                if !seenIngredients.contains(ingredientName) {
                    let ingredient = Ingredient(name: ingredientName, measurement: measure)
                    ingredients.append(ingredient)
                    // Add the ingredient to the seenIngredients set
                    seenIngredients.insert(ingredientName)
                }
            }
        }
    }
}
