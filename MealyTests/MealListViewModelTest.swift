//
//  MealListViewModelTest.swift
//  MealyTests
//
//  Created by Bryan Khufa on 11/11/23.
//

import XCTest
@testable import Mealy

final class MealListViewModelTest: XCTestCase {
    
    var sut: DefaultMealListViewModel!
    var useCase: MockMealUseCase!
    
    override func setUpWithError() throws {
        useCase = MockMealUseCase()
        sut = DefaultMealListViewModel(useCase: useCase)
    }
    
    override func tearDownWithError() throws {
        useCase = nil
    }
    
    func testFetchMeal_success() async {
        let mealData = [
            Meal(idMeal: "0", strMeal: "Nasi Goreng", strMealThumb: "", strInstructions: "Goreng nasi"),
            Meal(idMeal: "1", strMeal: "Nasi Kecap", strMealThumb: "", strInstructions: "Kecapi nasi")
        ]
        useCase.mockData = mealData
        
        XCTAssertFalse(useCase.fetchCalled)
        XCTAssertEqual(sut.meals, [])
        
        await sut.fetchMealList()
        
        XCTAssertTrue(useCase.fetchCalled)
        XCTAssertEqual(sut.meals, mealData)
    }
    
    func testFetchMeal_failed() async {
        useCase.shouldFail = true
        
        XCTAssertFalse(useCase.fetchCalled)
        XCTAssertEqual(sut.meals, [])
        
        await sut.fetchMealList()
        
        XCTAssertTrue(useCase.fetchCalled)
    }
}
