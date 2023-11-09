//
//  LoginViewModel.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation

final class LoginViewModel: AuthViewModel {
    
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
