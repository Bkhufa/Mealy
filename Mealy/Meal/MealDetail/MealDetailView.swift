//
//  MealDetailView.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import SwiftUI

struct MealDetailView: View {
    
    let meal: Meal
    let imageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    MealImage(imageUrl: meal.strMealThumb, imageSize: imageSize)
                    VStack {
                        Spacer()
                        HStack {
                            Text(meal.strMeal)
                                .lineLimit(nil)
                                .padding()
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(maxWidth: .infinity, minHeight: 75, alignment: .leading)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                                )
                        }
                    }
                }
                .frame(width: imageSize.width, height: imageSize.height)
                
                VStack(alignment: .leading) {
                    Text("Instructions")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 1)
                    Text(meal.strInstructions)
                        .padding(.horizontal, 20)
                }
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(meal: Meal.createPreview())
    }
}
