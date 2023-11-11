//
//  MealListViewModel.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import Foundation
import Alamofire

protocol MealListViewModel: ObservableObject {
    var meals: [Meal] { get }
    var alertMessage: AlertData { get }
    
    var shouldDisplayAlert: Bool { get set }
    
    func fetchMealList() async
    func fetchNextMealList() async
}

final class DefaultMealListViewModel: MealListViewModel {
    
    @Published var meals: [Meal] = []
    @Published var shouldDisplayAlert: Bool = false
    var alertMessage: AlertData = AlertData(title: "", message: "", actionLabel: "", action: nil) {
        didSet {
            shouldDisplayAlert = true
        }
    }
    var currentPage = 0
    
    private let useCase: MealUseCase
    
    init(useCase: MealUseCase) {
        self.useCase = useCase
    }
    
    @MainActor
    private func getMealList(firstLetter: String) async -> [Meal] {
        do {
            guard let meals = try await useCase.fetchMealList(firstLetter: firstLetter) else { return [] }
            return meals
        } catch {
            let alertData = AlertData(
                title: "Request Error",
                message: error.localizedDescription,
                actionLabel: "Retry",
                action: {
                    Task { [weak self] in
                        await self?.fetchMealList()
                    }
                }
            )

            if let err = error as? AFError {
                switch err {
                case .explicitlyCancelled:
                    break
                default:
                    alertMessage = alertData
                }
                return []
            }
            alertMessage = alertData
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
