//
//  MealListView.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import SwiftUI

struct MealListView<ViewModel>: View where ViewModel: MealListViewModel {
    
    @ObservedObject var viewModel: ViewModel
    private let imageSize = CGSize(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.width)
    
    var body: some View {
        List(viewModel.meals, id: \.self) { meal in
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: meal.strMealThumb), scale: 1) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .cornerRadius(20)
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Text("404! \n Image Not Available")
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.center)
                    default:
                        ProgressView()
                            .font(.largeTitle)
                    }
                }
                .modifier(PanZoomImage(contentSize: imageSize))
                Text(meal.strMeal)
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
            .padding(5)
            .padding(.bottom, 10)
            .frame(width: imageSize.width, height: imageSize.height)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
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
