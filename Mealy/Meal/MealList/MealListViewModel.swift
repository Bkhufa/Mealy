//
//  MealListViewModel.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import Foundation

protocol MealListViewModel: ObservableObject {
    var meals: [Meal] { get }
    
    func fetchMealList()
}

final class DefaultMealListViewModel: MealListViewModel {
    
    @Published var meals: [Meal] = []
    
    private let useCase: MealUseCase
    
    init(useCase: MealUseCase) {
        self.useCase = useCase
    }
    
    @MainActor
    func fetchMealList() {
        Task {
            meals = try await useCase.fetchMealList(firstLetter: "a")
        }
    }
}
