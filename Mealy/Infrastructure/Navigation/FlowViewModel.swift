//
//  FlowViewModel.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import Foundation

enum Screen {
    case auth
    case mealList
}

class FlowViewModel: ObservableObject {
    
    @Published var screen: Screen = .auth
    
    func navigateToMeal() {
        screen = .mealList
    }
    
    func navigateToAuth() {
        screen = .auth
    }
}
