//
//  AuthViewModel.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation

protocol AuthViewModel: ObservableObject {
    var screenTitle: String { get }
    var userName: String { get set }
    var password: String { get set }
    
    func onSubmitButtonTapped()
}

final class LoginAuthViewModel: AuthViewModel {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    
    private let useCase: AuthUseCase
    
    var screenTitle: String {
        "Login"
    }
    
    init(useCase: AuthUseCase) {
        self.useCase = useCase
    }
    
    func onSubmitButtonTapped() {
        useCase.login(userName: userName, password: password)
    }
}

final class RegisterAuthViewModel: AuthViewModel {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    
    private let useCase: AuthUseCase
    
    var screenTitle: String {
        "Register"
    }
    
    init(useCase: AuthUseCase) {
        self.useCase = useCase
    }
    
    func onSubmitButtonTapped() {
        useCase.register(userName: userName, password: password)
    }
}
