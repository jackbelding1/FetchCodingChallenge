//
//  MockMealSummary.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation
@testable import FetchCodingChallenge

class MockMealSummary: MealSummaryProtocol {
    var id: String { idMeal }
    var idMeal: String
    var strMeal: String?
    var strMealThumb: String?

    init(idMeal: String, strMeal: String?, strMealThumb: String?) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
}
