//
//  MockAuthUseCase.swift
//  MealyTests
//
//  Created by Bryan Khufa on 11/11/23.
//

import Foundation
@testable import Mealy

enum MockError: Error {
    case mockError
}

final class MockAuthUseCase: AuthUseCase {
    
    var loginCalled = false
    var registerCalled = false
    var saveCredentialsCalled = false
    
    var shouldFail = false
    
    func login(userName: String, password: String) throws -> Mealy.AuthModel {
        loginCalled = true
        if shouldFail {
            throw MockError.mockError
        }
        return AuthModel(userName: userName, password: password)
    }
    
    func register(userName: String, password: String) throws {
        registerCalled = true
        if shouldFail {
            throw MockError.mockError
        }
    }
    
    func saveCredential(_ credential: Mealy.AuthModel) throws {
        saveCredentialsCalled = true
        if shouldFail {
            throw MockError.mockError
        }
    }
}
