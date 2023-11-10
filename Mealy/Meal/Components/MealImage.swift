//
//  MealImage.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import SwiftUI

struct MealImage: View {
    
    let imageUrl: String
    let imageSize: CGSize
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl), scale: 1) { phase in
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
    }
}

struct MealImage_Previews: PreviewProvider {
    static var previews: some View {
        MealImage(imageUrl: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg", imageSize: CGSize(width: 100, height: 100))
    }
}
