//
//  MealListView.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import SwiftUI

struct MealListView<ViewModel>: View where ViewModel: MealListViewModel {
    
    @ObservedObject var viewModel: ViewModel
    private let imageSize = CGSize(width: 250, height: 250)
    
    var body: some View {
        List(viewModel.meals, id: \.self) { meal in
            VStack {
//                GeometryReader { proxy in
                    AsyncImage(url: URL(string: meal.strMealThumb), scale: 1) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 500, height: 500)
//                                .background(rectReader())
//                                .onAppear {
//                                    imageSize = CGSize(width: proxy.size.width, height: proxy.size.height)
//                                    print(imageSize)
//                                }
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
                    .padding()
                    .modifier(PanZoomImage(contentSize: CGSize(width: 250, height: 250)))
//                }
                Text(meal.strMeal)
            }
            .frame(width: 300, height: 300)
        }
        .onAppear {
            viewModel.fetchMealList()
        }
    }
    
    private func rectReader() -> some View {
        return GeometryReader { (geometry) -> Color in
            let imageSize = geometry.size
            DispatchQueue.main.async {
                print(">> \(imageSize)") // use image actual size in your calculations
//                self.imageSize = imageSize
            }
            return .clear
        }
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(viewModel: DefaultMealListViewModel(useCase: DefaultMealUseCase(service: AlamofireNetworkService())))
    }
}
