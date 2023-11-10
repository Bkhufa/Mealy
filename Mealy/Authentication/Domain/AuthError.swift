//
//  AuthError.swift
//  Mealy
//
//  Created by Bryan Khufa on 10/11/23.
//

import Foundation

enum AuthError: String, LocalizedError, CustomStringConvertible {
    case userNotFound = "Account Not Found"
    case wrongCombination = "Wrong combination of username and password"
    
    var description: String {
        let format = NSLocalizedString("%@", comment: "Error description")
        return String.localizedStringWithFormat(format, rawValue)
    }
}

extension LocalizedError where Self: CustomStringConvertible {
   var errorDescription: String? {
      return description
   }
}
