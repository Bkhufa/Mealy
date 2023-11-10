//
//  NetworkService.swift
//  Mealy
//
//  Created by Bryan Khufa on 10/11/23.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum NetworkError: String, LocalizedError, CustomStringConvertible {
    case invalidEndpoint = "Endpoint is Invalid"
    case emptyData = "Data is empty"
    
    var description: String {
        let format = NSLocalizedString("%@", comment: "Error description")
        return String.localizedStringWithFormat(format, rawValue)
    }
}

protocol NetworkService {
    func request<T: Endpoint>(_ endpoint: T) async throws -> T.Response
}

final class URLSessionNetworkService: NetworkService {
    
    func request<T: Endpoint>(_ endpoint: T) async throws -> T.Response {
        
        guard let urlRequest = makeURLRequest(endpoint) else {
            throw NetworkError.invalidEndpoint
        }
        
        let response = await AF.request(urlRequest, interceptor: .retryPolicy)
            .cacheResponse(using: .cache)
            .validate()
            .cURLDescription { description in
                print(description)
            }
            .serializingDecodable(T.Response.self)
            .response
            .value
        
        guard let response = response else { throw NetworkError.emptyData }
        return response
    }
    
    private func makeURLRequest<T: Endpoint>(_ endpoint: T) -> URLRequest? {
        let fullUrl = endpoint.apiBaseUrl + endpoint.url
        guard var urlComponent = URLComponents(string: fullUrl) else {
            return nil
        }
        
        var queryItems: [URLQueryItem] = []
        
        endpoint.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers
        return urlRequest
    }
}
