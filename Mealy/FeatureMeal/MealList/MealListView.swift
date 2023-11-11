//
//  MealListView.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import SwiftUI

struct MealListView<ViewModel>: View where ViewModel: MealListViewModel {
    
    @StateObject var viewModel: ViewModel
    @EnvironmentObject var flowViewModel: FlowViewModel

    private let imageSize = CGSize(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.width)
    
    var body: some View {
        NavigationStack {
            List {
                Section(footer: ProgressView()
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                    .task {
                        await viewModel.fetchNextMealList()
                    }) {
                        ForEach(viewModel.meals, id: \.self) { meal in
                            ZStack {
                                NavigationLink(value: meal) { EmptyView() }
                                    .opacity(0.0)
                                MealCard(meal: meal, imageSize: imageSize)
                            }
                            .listRowSeparator(.hidden)
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
            .alert(isPresented: $viewModel.shouldDisplayAlert) {
                Alert(
                    title: Text(viewModel.alertMessage.title),
                    message: Text(viewModel.alertMessage.message),
                    dismissButton: .default(Text(viewModel.alertMessage.actionLabel), action: {
                        viewModel.alertMessage.action?()
                    })
                )
            }
        }
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(viewModel: DefaultMealListViewModel(useCase: DefaultMealUseCase(service: AlamofireNetworkService())))
    }
}
