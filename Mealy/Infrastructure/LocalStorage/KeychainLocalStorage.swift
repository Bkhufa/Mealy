//
//  KeychainLocalStorage.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation
import Security

struct KeyChainLocalStorage: LocalStorage {
    
    func writeToLocalStorage<T: LocalModel>(_ content: T) throws {
        guard SecItemAdd(content.mapToWriteKeychain(), nil) == noErr
        else {
            guard SecItemDelete(content.mapToWriteKeychain()) == noErr else { throw LocalStorageError.failedToUpdate }
            guard SecItemAdd(content.mapToWriteKeychain(), nil) == noErr else { throw LocalStorageError.failedToWrite }
            return
        }
        return
    }
    
    func readFromLocalStorage<T: LocalModel>(_ content: T) throws -> T? {
        var item: CFTypeRef?
        guard SecItemCopyMatching(content.mapToReadKeychain(), &item) == noErr else { throw LocalStorageError.failedToRead }
        return content.mapFromKeychain(model: item)
    }
}

struct KeyChainModel: LocalModel {
    let key: String
    let value: Data?
    
    func mapToWriteKeychain() -> CFDictionary {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: value ?? "",
        ]
        return attributes as CFDictionary
    }
    
    func mapToReadKeychain() -> CFDictionary {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        return query as CFDictionary
    }
    
    func mapFromKeychain(model: CFTypeRef?) -> Self? {
        guard let model = model as? [String: Any],
              let key = model[kSecAttrAccount as String] as? String,
              let value = model[kSecValueData as String] as? Data
        else { return nil }
        return .init(key: key, value: value)
    }
}
