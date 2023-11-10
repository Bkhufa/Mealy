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

struct Meal: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}
