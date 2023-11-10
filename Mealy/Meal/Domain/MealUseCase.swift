//
//  MealUseCase.swift
//  Mealy
//
//  Created by Bryan Khufa on 10/11/23.
//

import Foundation

protocol MealUseCase {
    func fetchMealList() async throws -> [Meal]
}

final class DefaultMealUseCase: MealUseCase {
    
    private let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func fetchMealList() async throws -> [Meal] {
        return []
    }
    
}
