//
//  MealListView.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import SwiftUI

struct MealListView<ViewModel>: View where ViewModel: MealListViewModel {
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var flowViewModel: FlowViewModel

    private let imageSize = CGSize(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.width)
    
    var body: some View {
        NavigationStack {
            List {
                Section(footer: ProgressView()
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                    .listRowSeparator(.hidden)
                    .task {
                        await viewModel.fetchNextMealList()
                    }) {
                        ForEach(viewModel.meals, id: \.self) { meal in
                            ZStack {
                                NavigationLink(value: meal) { EmptyView() }
                                    .opacity(0.0)
                                MealCard(meal: meal, imageSize: imageSize)
                            }
                        }
                    }
            }
            .listStyle(.plain)
            .task {
                await viewModel.fetchMealList()
            }
            .navigationDestination(for: Meal.self, destination: MealDetailView.init)
            .navigationTitle("Mealy")
            .toolbar {
                Button {
                    flowViewModel.navigateToAuth()
                } label: {
                    Image(systemName:  "rectangle.portrait.and.arrow.right")
                }
            }
        }
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(viewModel: DefaultMealListViewModel(useCase: DefaultMealUseCase(service: AlamofireNetworkService())))
    }
}
