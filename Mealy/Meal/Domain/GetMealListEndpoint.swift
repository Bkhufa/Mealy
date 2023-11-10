//
//  MealEndpoint.swift
//  Mealy
//
//  Created by Bryan Khufa on 10/11/23.
//

import Foundation

struct GetMealListEndpoint: Endpoint {
    
    typealias Response = MealResponse
    
    private let firstLetter: String
    
    init(firstLetter: String) {
        self.firstLetter = firstLetter
    }
    
    var url: String {
        "search.php"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String : String] {
        [
            "f": firstLetter,
        ]
    }
}
