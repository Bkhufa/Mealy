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
        XCTAssertEqual(sut.currentPage, 1)
    }
    
    func testFetchMeal_failed() async {
        useCase.shouldFail = true
        
        XCTAssertFalse(useCase.fetchCalled)
        
        await sut.fetchMealList()
        
        XCTAssertTrue(useCase.fetchCalled)
        XCTAssertEqual(sut.meals, [])
        XCTAssertTrue(sut.shouldDisplayAlert)
        XCTAssertEqual(sut.alertMessage.title, "Request Error")
    }
    
    func testFetchNextMealList_success() async {
        let mealData = [
            Meal(idMeal: "0", strMeal: "Nasi Goreng", strMealThumb: "", strInstructions: "Goreng nasi"),
            Meal(idMeal: "1", strMeal: "Nasi Kecap", strMealThumb: "", strInstructions: "Kecapi nasi")
        ]
        useCase.mockData = mealData
        
        XCTAssertFalse(useCase.fetchCalled)
        XCTAssertEqual(sut.meals, [])
        
        await sut.fetchNextMealList()
        
        XCTAssertTrue(useCase.fetchCalled)
        XCTAssertEqual(sut.meals, mealData)
        XCTAssertEqual(sut.currentPage, 1)
    }
    
    func testFetchNextMealList_failed() async {
        useCase.shouldFail = true
        
        XCTAssertFalse(useCase.fetchCalled)
        
        await sut.fetchNextMealList()
        
        XCTAssertTrue(useCase.fetchCalled)
        XCTAssertEqual(sut.meals, [])
        XCTAssertTrue(sut.shouldDisplayAlert)
        XCTAssertEqual(sut.alertMessage.title, "Request Error")
    }
    
    func testFetchInitialMeal_thenFetchNextMeal() async {
        let mealData = [
            Meal(idMeal: "0", strMeal: "Nasi Goreng", strMealThumb: "", strInstructions: "Goreng nasi"),
            Meal(idMeal: "1", strMeal: "Nasi Kecap", strMealThumb: "", strInstructions: "Kecapi nasi")
        ]
        useCase.mockData = mealData
        
        XCTAssertFalse(useCase.fetchCalled)
        
        await sut.fetchMealList()
        await sut.fetchNextMealList()
        
        XCTAssertTrue(useCase.fetchCalled)
        XCTAssertEqual(sut.meals.count, 4)
        XCTAssertEqual(sut.currentPage, 2)
    }
    
    func testFetchInitialMeal_thenFetchNextMeal_failed() async {
        let mealData = [
            Meal(idMeal: "0", strMeal: "Nasi Goreng", strMealThumb: "", strInstructions: "Goreng nasi"),
            Meal(idMeal: "1", strMeal: "Nasi Kecap", strMealThumb: "", strInstructions: "Kecapi nasi")
        ]
        useCase.mockData = mealData
        
        XCTAssertFalse(useCase.fetchCalled)
        
        await sut.fetchMealList()
        useCase.shouldFail = true
        await sut.fetchNextMealList()
        
        XCTAssertTrue(useCase.fetchCalled)
        XCTAssertEqual(sut.meals.count, 2)
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertTrue(sut.shouldDisplayAlert)
        XCTAssertEqual(sut.alertMessage.title, "Request Error")
    }
}
