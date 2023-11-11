//
//  Meal.swift
//  Mealy
//
//  Created by Bryan Khufa on 10/11/23.
//

import Foundation

struct MealResponse: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable, Hashable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    
    static func createPreview() -> Self {
        Meal(idMeal: "1", strMeal: "Eye Cow Egg Lorem Ipsum Dolor sit amet", strMealThumb: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg", strInstructions: "Crack an egg and then put it on a flaming hot pan")
    }
}
