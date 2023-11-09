//
//  MealDetailViewModelTest.swift
//  FetchCodingChallengeTests
//
//  Created by Jack Belding on 11/6/23.
//

import XCTest
@testable import FetchCodingChallenge

class MealDetailViewModelTests: XCTestCase {
    
    var viewModel: MealDetailViewModel!
    var mockRepository: MockMealRepository!
    
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
    
    func testFetchingMealDetailSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Meal detail fetched successfully")
        mockRepository = MockMealRepository()
        mockRepository.shouldReturnSuccess = true
        viewModel = MealDetailViewModel(repository: mockRepository, mealID: "1")
        // When
        viewModel.loadMealDetail()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.mealDetail)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchingMealDetailFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Meal detail fetching failed")
        mockRepository = MockMealRepository()
        mockRepository.shouldReturnSuccess = false
        viewModel = MealDetailViewModel(repository: mockRepository, mealID: "1")
        viewModel.mealDetail = nil
        
        // When
        viewModel.loadMealDetail()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNil(self.viewModel.mealDetail)
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    // Add more tests as necessary to cover the functionality of the view model.
}
