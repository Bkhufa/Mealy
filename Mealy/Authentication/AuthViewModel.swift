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
    
    var screenTitle: String {
        "Login"
    }
    
    func onSubmitButtonTapped() {
    }
}
