//
//  MockMealUseCase.swift
//  MealyTests
//
//  Created by Bryan Khufa on 11/11/23.
//

import Foundation
@testable import Mealy

final class MockMealUseCase: MealUseCase {
    
    var shouldFail = false
    var fetchCalled = false
    var mockData: [Meal] = []
    
    func fetchMealList(firstLetter: String) async throws -> [Meal]? {
        fetchCalled = true
        if shouldFail {
            throw MockError.mockError
        }
        return mockData
    }
}
