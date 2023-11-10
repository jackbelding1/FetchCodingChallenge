//
//  MealSummaryViewModel.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

// MARK: - Meal Summary View Model

class MealSummaryViewModel: MealSummaryViewModelProtocol, ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var mealSummaries = [any MealSummaryProtocol]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var mealDetail: (any MealDetailProtocol)?
    
    // MARK: - Private Properties
    
    private let repository: MealRepositoryProtocol
    
    // MARK: - Initializer
    
    init(repository: MealRepositoryProtocol) {
        self.repository = repository
        fetchMealSummaries()
    }
    
    // MARK: - Fetching Data
    
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

// MARK: - Extensions

extension MealSummaryViewModel {
    
    // MARK: - Computed Properties
    
    var sortedMealSummaries: [any MealSummaryProtocol] {
        mealSummaries
            .filter { $0.strMeal != nil } // Filter out nil values
            .sorted { ($0.strMeal ?? "") < ($1.strMeal ?? "") } // Sort the remaining
    }
}
