//
//  MealDetailViewModel.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation


import UIKit

class MealDetailViewModel: MealDetailViewModelProtocol {
    // MARK: - Properties
    @Published var error: Error?
    @Published var mealDetail: any MealDetailProtocol
    
    // MARK: - Initialization
    
    init(mealDetail: any MealDetailProtocol) {
        self.mealDetail = mealDetail
    }
    
    // MARK: - Actions
    
    func openLink(_ urlString: String) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            error = URLError(.badURL)
            return
        }
        
        // Attempt to open the URL
        UIApplication.shared.open(url) { success in
            if !success {
                self.error = URLError(.cannotOpenFile)
            }
        }
    }
}
