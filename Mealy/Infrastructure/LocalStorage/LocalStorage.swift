//
//  LocalStorage.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation

protocol LocalStorage {
    func writeToLocalStorage<T: LocalModel>(_ content: T) throws
    func readFromLocalStorage<T: LocalModel>(_ content: T) throws -> T?
}

protocol LocalModel {
    func mapToWriteKeychain() -> CFDictionary
    func mapToReadKeychain() -> CFDictionary
    func mapFromKeychain(model: CFTypeRef?) -> Self?
}

enum LocalStorageError: Error {
    case failedToWrite
    case failedToRead
    case failedToUpdate
}
