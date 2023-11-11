//
//  MealListViewModel.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import Foundation

protocol MealListViewModel: ObservableObject {
    var meals: [Meal] { get }
    
    func fetchMealList() async
    func fetchNextMealList() async
}

final class DefaultMealListViewModel: MealListViewModel {
    
    @Published var meals: [Meal] = []
    var currentPage = 0
    
    private let useCase: MealUseCase
    
    init(useCase: MealUseCase) {
        self.useCase = useCase
    }
    
    private func getMealList(firstLetter: String) async -> [Meal] {
        do {
            return try await useCase.fetchMealList(firstLetter: firstLetter)
        } catch {
            //TODO: Handle error
            print(error)
        }
        return []
    }
    
    @MainActor
    func fetchMealList() async {
        currentPage = 0
        meals = await getMealList(firstLetter: "a")
    }
    
    @MainActor
    func fetchNextMealList() async {
        if currentPage <= 26 {
            currentPage += 1
            let startingValue = Int(("a" as UnicodeScalar).value)
            guard let nextUnicode = UnicodeScalar(currentPage + startingValue) else { return }
            let nextFirstLetter = String(nextUnicode)
            let nextMeals = await getMealList(firstLetter: nextFirstLetter)
            meals += nextMeals
        }
    }
}
