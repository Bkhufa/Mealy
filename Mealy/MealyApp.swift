//
//  MealyApp.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import SwiftUI

@main
struct MealyApp: App {
    var body: some Scene {
        WindowGroup {
            AuthView(viewModel: LoginViewModel(useCase: DefaultAuthUseCase(storage: KeyChainLocalStorage())))
        }
    }
}
