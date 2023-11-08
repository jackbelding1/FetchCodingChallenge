//
//  MealSummaryViewModel.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

class MealSummaryViewModel: MealSummaryViewModelProtocol, ObservableObject {
    
    @Published var mealSummaries = [any MealSummaryProtocol]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var mealDetail: (any MealDetailProtocol)?
    
    private let repository: MealRepositoryProtocol
    
    init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchMealSummaries()  {
        isLoading = true
        errorMessage = nil
        
        repository.fetchMealSummaries { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let summaries):
                    self?.mealSummaries = summaries
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                self?.isLoading = false
            }
        }
    }
    
    func fetchMealDetail(forId id: String) {
        isLoading = true
        errorMessage = nil
        
        repository.fetchMealDetail(forId: id) { [weak self] result in
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


extension MealSummaryViewModel {
    var sortedMealSummaries: [any MealSummaryProtocol] {
        mealSummaries
            .filter { $0.strMeal != nil } // Filter out nil values
            .sorted { ($0.strMeal ?? "") < ($1.strMeal ?? "") } // Sort the remaining
    }
}
