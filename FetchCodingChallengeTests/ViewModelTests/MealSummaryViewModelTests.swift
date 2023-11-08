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
        // Provide mock data for meal detail
        let mockIngredients = [
            Ingredient(name: "Ingredient1", measurement: "1 cup"),
            // Add more mock ingredients as needed
        ]

        let mockDetail = MockMealDetail(
            idMeal: "1",
            strMeal: "Mock Meal",
            strInstructions: "Mock Instructions",
            strMealThumb: "mockThumbURL",
            strTags: "Mock Tags",
            strYoutube: "mockYoutubeURL",
            strSource: "mockSourceURL",
            ingredients: mockIngredients
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
    
    func testSortedMealSummaries() {
        // Arrange
        let mockMealSummary1 = MockMealSummary(idMeal: "1", strMeal: "Banana Split", strMealThumb: "")
        let mockMealSummary2 = MockMealSummary(idMeal: "2", strMeal: nil, strMealThumb: "")
        let mockMealSummary3 = MockMealSummary(idMeal: "3", strMeal: "Apple Pie", strMealThumb: "")
        mockRepository.mockMealSummaries = [mockMealSummary1, mockMealSummary2, mockMealSummary3]
        
        // Act
        viewModel.fetchMealSummaries()
        
        // Wait for the async fetch to complete
        DispatchQueue.main.async {
            // Assert
            XCTAssertEqual(self.viewModel.sortedMealSummaries.count, 2)
            XCTAssertEqual(self.viewModel.sortedMealSummaries[0].idMeal, "3") // "Apple Pie" should come before "Banana Split"
            XCTAssertEqual(self.viewModel.sortedMealSummaries[1].idMeal, "1")
            XCTAssertNil(self.viewModel.sortedMealSummaries.first { $0.strMeal == nil }) // There should be no nil `strMeal`
        }
    }

}
