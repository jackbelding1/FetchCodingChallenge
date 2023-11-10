//
//  MealDetailViewModelTest.swift
//  FetchCodingChallengeTests
//
//  Created by Jack Belding on 11/6/23.
//

import XCTest
@testable import FetchCodingChallenge

// MARK: - Meal Detail View Model Tests

class MealDetailViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: MealDetailViewModel!
    var mockRepository: MockMealRepository!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        super.setUp()
        mockRepository = MockMealRepository()
        viewModel = MealDetailViewModel(repository: mockRepository, mealID: "1")
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: Fetching Meal Detail Success
    
    func testFetchingMealDetailSuccess() {
        let expectation = XCTestExpectation(description: "Meal detail fetched successfully")
        mockRepository = MockMealRepository()
        mockRepository.shouldReturnSuccess = true
        viewModel = MealDetailViewModel(repository: mockRepository, mealID: "1")

        viewModel.loadMealDetail()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.mealDetail)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    // MARK: Fetching Meal Detail Failure
    
    func testFetchingMealDetailFailure() {
        let expectation = XCTestExpectation(description: "Meal detail fetching failed")
        mockRepository = MockMealRepository()
        mockRepository.shouldReturnSuccess = false
        viewModel = MealDetailViewModel(repository: mockRepository, mealID: "1")
        viewModel.mealDetail = nil
        
        viewModel.loadMealDetail()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNil(self.viewModel.mealDetail)
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
}
