//
//  AppFlowView.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import SwiftUI

struct AppFlowView: View {
    
    @EnvironmentObject var flowViewModel: FlowViewModel
    
    var body: some View {
        switch flowViewModel.screen {
        case .auth:
            AuthView(viewModel: DefaultAuthViewModel(authType: .register, useCase: DefaultAuthUseCase(storage: KeyChainLocalStorage())))
        case .mealList:
            MealListView(viewModel: DefaultMealListViewModel(useCase: DefaultMealUseCase(service: AlamofireNetworkService())))
        }
    }
}
