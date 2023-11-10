//
//  MealDetailViewModel.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation
import UIKit

// MARK: - Meal Detail View Model

class MealDetailViewModel: MealDetailViewModelProtocol, ObservableObject {
    
    // MARK: - Properties
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var mealDetail: (any MealDetailProtocol)?
    
    private let repository: MealRepositoryProtocol
    private let mealID: String
    
    // MARK: - Initializer
    
    init(repository: MealRepositoryProtocol, mealID: String) {
        self.repository = repository
        self.mealID = mealID
        loadMealDetail()
    }
    
    // MARK: - Actions
    
    func loadMealDetail() {
        isLoading = true
        repository.fetchMealDetail(forId: mealID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detail):
                    self?.mealDetail = detail
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                self?.isLoading = false
            }
        }
    }
}
