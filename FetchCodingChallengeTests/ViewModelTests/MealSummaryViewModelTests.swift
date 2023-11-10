//
//  MealSummaryViewModelTests.swift
//  FetchCodingChallengeTests
//
//  Created by Jack Belding on 11/6/23.
//

@testable import FetchCodingChallenge
import XCTest

// MARK: - Meal Summary View Model Tests

class MealSummaryViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: MealSummaryViewModel!
    var mockRepository: MockMealRepository!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        super.setUp()
        mockRepository = MockMealRepository()
        viewModel = MealSummaryViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases for Fetching Meal Summaries
    
    func testFetchMealSummariesSuccess() {
        let mockMealSummary1 = MockMealSummary(idMeal: "1", strMeal: "Banana Split", strMealThumb: "")
        let mockMealSummary2 = MockMealSummary(idMeal: "2", strMeal: nil, strMealThumb: "")
        let mockMealSummary3 = MockMealSummary(idMeal: "3", strMeal: "Apple Pie", strMealThumb: "")
        mockRepository.mockMealSummaries = [mockMealSummary1, mockMealSummary2, mockMealSummary3]
        mockRepository.shouldReturnSuccess = true
        let expectation = XCTestExpectation(description: "Fetch meal summaries success")
        
        viewModel.fetchMealSummaries()
        
        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.mealSummaries)
            XCTAssertTrue(self.viewModel.mealSummaries.count > 0)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
        
    func testFetchMealSummariesFailure() {
        mockRepository.shouldReturnSuccess = false
        let expectation = XCTestExpectation(description: "Fetch meal summaries failure")
        
        viewModel.fetchMealSummaries()
        
        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(self.viewModel.mealSummaries.isEmpty)
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Test Cases for Loading Meal Detail
    
    func testLoadMealDetailSuccess() {
        mockRepository.shouldReturnSuccess = true
        
        let expectation = self.expectation(description: "Meal Detail Fetch Success")
        
        viewModel.fetchMealDetail(forId: "1")
        
        DispatchQueue.main.async {
            XCTAssertNotNil(self.viewModel.mealDetail)
            XCTAssertEqual(self.viewModel.mealDetail?.idMeal, "1")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testLoadMealDetailFailure() {
        mockRepository.shouldReturnSuccess = false
        
        let expectation = self.expectation(description: "Meal Detail Fetch Failure")
        
        viewModel.fetchMealDetail(forId: "1")
        
        DispatchQueue.main.async {
            XCTAssertNil(self.viewModel.mealDetail)
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    // MARK: - Test for Sorted Meal Summaries
    
    func testSortedMealSummaries() {
        let mockMealSummary1 = MockMealSummary(idMeal: "1", strMeal: "Banana Split", strMealThumb: "")
        let mockMealSummary2 = MockMealSummary(idMeal: "2", strMeal: nil, strMealThumb: "")
        let mockMealSummary3 = MockMealSummary(idMeal: "3", strMeal: "Apple Pie", strMealThumb: "")
        mockRepository.mockMealSummaries = [mockMealSummary1, mockMealSummary2, mockMealSummary3]

        let expectation = XCTestExpectation(description: "Fetch meal summaries and sort them")

        viewModel.fetchMealSummaries()
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.sortedMealSummaries.count, 2)
            XCTAssertEqual(self.viewModel.sortedMealSummaries[0].idMeal, "3") // "Apple Pie" should come before "Banana Split"
            XCTAssertEqual(self.viewModel.sortedMealSummaries[1].idMeal, "1")
            XCTAssertNil(self.viewModel.sortedMealSummaries.first { $0.strMeal == nil }) // There should be no nil `strMeal`
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
