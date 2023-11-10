//
//  AuthViewModel.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation

protocol AuthViewModel: ObservableObject {
    var screenTitle: String { get }
    var toggleButtonLabel: String { get }
    
    var userName: String { get set }
    var password: String { get set }
    
    func onSubmitButtonTapped()
    func toggleAuthType()
}

enum AuthType: String {
    case login
    case register
    
    var toggleButtonLabel: String {
        switch self {
        case .login:
            return "Didn't have an account yet? Register now!"
        case .register:
            return "Already have an account? Login here!"
        }
    }
}

final class DefaultAuthViewModel: AuthViewModel {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var authType: AuthType
    
    private let useCase: AuthUseCase
    
    var screenTitle: String {
        authType.rawValue.capitalized
    }
    
    var toggleButtonLabel: String {
        authType.toggleButtonLabel
    }
    
    init(authType: AuthType, useCase: AuthUseCase) {
        self.useCase = useCase
        self.authType = authType
    }
    
    func onSubmitButtonTapped() {
        do {
            switch authType {
            case .login:
                let credential = try useCase.login(userName: userName, password: password)
                try useCase.saveCredential(credential)
            case .register:
                try useCase.register(userName: userName, password: password)
            }
        } catch {
            //TODO: Handle Error
            print(error)
        }
    }
    
    func toggleAuthType() {
        if case .login = authType {
            authType = .register
            return
        }
        authType = .login
    }
}

