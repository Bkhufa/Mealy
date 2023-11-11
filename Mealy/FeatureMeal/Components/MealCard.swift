//
//  MealCard.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import SwiftUI

struct MealCard: View {
    
    let meal: Meal
    let imageSize: CGSize
    
    var body: some View {
        VStack(alignment: .center) {
            MealImage(imageUrl: meal.strMealThumb, imageSize: imageSize)
            Text(meal.strMeal)
                .font(.title)
                .multilineTextAlignment(.center)
        }
        .padding(5)
        .padding(.bottom, 10)
        .frame(width: imageSize.width, height: imageSize.height)
    }
}

struct MealCard_Previews: PreviewProvider {
    static var previews: some View {
        MealCard(meal: Meal.createPreview(), imageSize: CGSize(width: 100, height: 100))
    }
}
