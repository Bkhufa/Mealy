//
//  AuthModel.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation

struct AuthModel: Equatable {
    let userName: String
    let password: String
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
}

extension AuthModel {
    
    init?(keychainModel: KeyChainModel) {
        guard let value = keychainModel.value,
              let decodedString = value.base64Decoded?.string
        else { return nil }
        self.init(userName: keychainModel.key, password: decodedString)
    }
    
    func mapToKeychain() -> KeyChainModel {
        KeyChainModel(key: userName, value: password.base64Encoded)
    }
}
