//
//  AuthUseCase.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation

protocol AuthUseCase {
    func login(userName: String, password: String)
    func register(userName: String, password: String)
}

struct DefaultAuthUseCase: AuthUseCase {
    
    private var storage: KeyChainLocalStorage<AuthModel>
    
    init(storage: KeyChainLocalStorage<AuthModel>) {
        self.storage = storage
    }
    
    //TODO: Base64 encoding
    func login(userName: String, password: String) {
        let inputCredential = AuthModel(userName: userName, password: password)
        guard let retreivedCredential = storage.readFromLocalStorage(inputCredential) else { return }
        
        if inputCredential == retreivedCredential {
            print("Login successful")
            return
        }
        print("Failed to login")
    }
    
    func register(userName: String, password: String) {
        storage.writeToLocalStorage(AuthModel(userName: userName, password: password))
    }
}
