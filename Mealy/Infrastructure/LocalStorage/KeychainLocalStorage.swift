//
//  KeychainLocalStorage.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation
import Security

struct KeyChainLocalStorage<T: LocalModel>: LocalStorage {
    
    func writeToLocalStorage(_ content: T) {
        if SecItemAdd(content.mapToWriteKeychain(), nil) == noErr {
            print("User saved successfully in the keychain")
        } else {
            print("Something went wrong trying to save the user in the keychain")
        }
    }
    
    func readFromLocalStorage(_ content: T) -> T? {
        var item: CFTypeRef?
        if SecItemCopyMatching(content.mapToReadKeychain() as CFDictionary, &item) == noErr {
            return content.mapFromKeychain(model: item)
        } else {
            print("Something went wrong trying to find the user in the keychain")
            return nil
        }
    }
    
}
