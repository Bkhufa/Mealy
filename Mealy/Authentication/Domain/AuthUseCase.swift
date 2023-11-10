//
//  AuthUseCase.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation

protocol AuthUseCase {
    func login(userName: String, password: String) throws -> AuthModel
    func register(userName: String, password: String) throws
    func saveCredential(_ credential: AuthModel) throws
}

struct DefaultAuthUseCase: AuthUseCase {
    
    private var storage: KeyChainLocalStorage
    
    init(storage: KeyChainLocalStorage) {
        self.storage = storage
    }
    
    func login(userName: String, password: String) throws -> AuthModel {
        let inputCredential = AuthModel(userName: userName, password: password)
        guard let retrievedObject = storage.readFromLocalStorage(inputCredential.mapToKeychain()) else { throw AuthError.userNotFound }
        let retreivedCredential = AuthModel(keychainModel: retrievedObject)
        
        if inputCredential == retreivedCredential {
            return inputCredential
        }
        
        throw AuthError.wrongCombination
    }
    
    func register(userName: String, password: String) throws {
        let model = AuthModel(userName: userName, password: password).mapToKeychain()
        try storage.writeToLocalStorage(model)
    }
    
    func saveCredential(_ credential: AuthModel) throws {
        let concatenatedCredential = credential.userName + "\\" + credential.password
        let base64Data = concatenatedCredential.base64Encoded
        let keychainModel = KeyChainModel(key: "credentials", value: base64Data)
        try storage.writeToLocalStorage(keychainModel)
        try retrieveCredential()
    }
    
    // TODO: Remove
    func retrieveCredential() throws {
        let anu = storage.readFromLocalStorage(KeyChainModel(key: "credentials", value: nil))
        print("cred", anu?.value?.base64Decoded?.string)
    }
}
