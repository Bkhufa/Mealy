//
//  RegisterViewModel.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation

final class RegisterViewModel: AuthViewModel {
    
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
