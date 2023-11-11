//
//  MealyApp.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import SwiftUI

@main
struct MealyApp: App {
    @State var isLoggedIn: Bool = true
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MealListView(viewModel: DefaultMealListViewModel(useCase: DefaultMealUseCase(service: AlamofireNetworkService())))
            } else {
                AuthView(viewModel: DefaultAuthViewModel(authType: .register, useCase: DefaultAuthUseCase(storage: KeyChainLocalStorage()), isLoggedIn: isLoggedIn))
            }
        }
    }
}
