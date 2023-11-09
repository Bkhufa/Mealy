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
}

extension AuthModel: LocalModel {
    
    func mapToWriteKeychain() -> CFDictionary {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: userName,
            kSecValueData as String: password.data(using: .utf8) ?? "",
        ]
        return attributes as CFDictionary
    }
    
    func mapToReadKeychain() -> CFDictionary {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: userName,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        return query as CFDictionary
    }
    
    func mapFromKeychain(model: CFTypeRef?) -> Self? {
        guard let model = model as? [String: Any],
              let username = model[kSecAttrAccount as String] as? String,
              let passwordData = model[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: .utf8)
        else { return nil }
        return .init(userName: username, password: password)
    }
}
