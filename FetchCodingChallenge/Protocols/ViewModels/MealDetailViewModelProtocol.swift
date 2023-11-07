//
//  MealDetailViewModelProtocol.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

protocol MealDetailViewModelProtocol: AnyObject {
    var mealDetail: any MealDetailProtocol { get }
    func openLink(_ url: String)
    var error: Error? { get }
    
}
