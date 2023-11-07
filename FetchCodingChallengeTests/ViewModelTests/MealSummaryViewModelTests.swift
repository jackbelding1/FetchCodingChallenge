//
//  MealSummaryViewModelTests.swift
//  FetchCodingChallengeTests
//
//  Created by Jack Belding on 11/6/23.
//

@testable import FetchCodingChallenge
import XCTest

class MealSummaryViewModelTests: XCTestCase {
    var viewModel: MealSummaryViewModel!
    var mockRepository: MockMealRepository!
    
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
    
    func testFetchMealSummariesSuccess() {
        // Arrange
        mockRepository.shouldReturnSuccess = true
        let expectation = XCTestExpectation(description: "Fetch meal summaries success")
        
        // Act
        viewModel.fetchMealSummaries()
        
        // Wait for the async call to complete
        DispatchQueue.main.async {
            // Assert
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.mealSummaries)
            XCTAssertTrue(self.viewModel.mealSummaries.count > 0)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchMealSummariesFailure() {
        // Arrange
        mockRepository.shouldReturnSuccess = false
        let expectation = XCTestExpectation(description: "Fetch meal summaries failure")
        
        // Act
        viewModel.fetchMealSummaries()
        
        // Wait for the async call to complete
        DispatchQueue.main.async {
            // Assert
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(self.viewModel.mealSummaries.isEmpty)
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadMealDetailSuccess() {
        // Create a mock meal detail conforming to the protocol
        let mockMealDetail = MockMealDetail(
            idMeal: "1",
            strMeal: "Mock Meal Detail",
            strInstructions: "Some instructions",
            strMealThumb: "MockDetailThumbURL",
            strTags: "Tag1,Tag2",
            strYoutube: "MockYoutubeURL",
            strSource: "MockSourceURL",
            ingredients: ["Ingredient1": "1 cup", "Ingredient2": "2 tsp"]
        )
        
        // Stub the repository to simulate a successful fetch with the mock data
        mockRepository.shouldReturnSuccess = true
        
        // Define an expectation
        let expectation = self.expectation(description: "Meal Detail Fetch Success")
        
        // Act
        viewModel.fetchMealDetail(forId: "1")
        
        // Since the fetch is async, we wait for the expectation to be fulfilled
        DispatchQueue.main.async {
            // Assert
            XCTAssertNotNil(self.viewModel.mealDetail)
            XCTAssertEqual(self.viewModel.mealDetail?.idMeal, "1")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testLoadMealDetailFailure() {
        // Stub the repository to simulate a failure
        mockRepository.shouldReturnSuccess = false
        
        // Define an expectation
        let expectation = self.expectation(description: "Meal Detail Fetch Failure")
        
        // Act
        viewModel.fetchMealDetail(forId: "1")
        
        // Since the fetch is async, we wait for the expectation to be fulfilled
        DispatchQueue.main.async {
            // Assert
            XCTAssertNil(self.viewModel.mealDetail)
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}
