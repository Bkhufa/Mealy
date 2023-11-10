//
//  Endpoint.swift
//  Mealy
//
//  Created by Bryan Khufa on 10/11/23.
//

import Foundation

protocol Endpoint {
    associatedtype Response: Decodable
    
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String] { get }
    var queryItems: [String : String] { get }
}

extension Endpoint {
    
    var apiBaseUrl: String {
        "https://www.themealdb.com/api/json/v1/1/"
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [:]
    }
}
