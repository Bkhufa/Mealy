//
//  LocalStorage.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation

protocol LocalStorage {
    associatedtype T: LocalModel
    func writeToLocalStorage(_ content: T)
    func readFromLocalStorage(_ content: T) -> T?
}

protocol LocalModel {
    func mapToWriteKeychain() -> CFDictionary
    func mapToReadKeychain() -> CFDictionary
    func mapFromKeychain(model: CFTypeRef?) -> Self?
}
