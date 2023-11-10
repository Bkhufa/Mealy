//
//  MealListView.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import SwiftUI

struct MealListView<ViewModel>: View where ViewModel: MealListViewModel {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.meals, id: \.self) { meal in
            Text(meal.strMeal)
        }
        .onAppear {
            viewModel.fetchMealList()
        }
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(viewModel: DefaultMealListViewModel(useCase: DefaultMealUseCase(service: AlamofireNetworkService())))
    }
}
