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
        if SecItemAdd(content.mapToWriteKeychain(), nil) == noErr {
            return
        }
        if SecItemDelete(content.mapToWriteKeychain()) == noErr {
            if SecItemAdd(content.mapToWriteKeychain(), nil) == noErr {
                return
            }
            LocalStorageError.failedToUpdate
        }
        throw LocalStorageError.failedToWrite
    }
    
    func readFromLocalStorage<T: LocalModel>(_ content: T) throws -> T? {
        var item: CFTypeRef?
        if SecItemCopyMatching(content.mapToReadKeychain() as CFDictionary, &item) == noErr {
            return content.mapFromKeychain(model: item)
        } else {
            throw LocalStorageError.failedToRead
        }
    }
}

struct KeyChainModel: LocalModel {
    let key: String
    let value: Data?
    
    func mapToWriteKeychain() -> CFDictionary {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: value,
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
