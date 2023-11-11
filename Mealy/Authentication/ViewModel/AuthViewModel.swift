//
//  AuthViewModel.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import Foundation

protocol AuthViewModel: ObservableObject {
    var screenTitle: String { get }
    var toggleButtonLabel: String { get }
    var alertMessage: AlertData { get }
    
    var userName: String { get set }
    var password: String { get set }
    var shouldDisplayAlert: Bool { get set }
    
    func onSubmitTappedShouldNavigate() -> Bool
    func toggleAuthType()
}

enum AuthType: String {
    case login
    case register
    
    var toggleButtonLabel: String {
        switch self {
        case .login:
            return "Didn't have an account yet? Register now!"
        case .register:
            return "Already have an account? Login here!"
        }
    }
}

final class DefaultAuthViewModel: AuthViewModel {
    
    @Published var authType: AuthType
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var shouldDisplayAlert: Bool = false
    @Published var alertMessage: AlertData = AlertData(title: "", message: "", actionLabel: "", action: nil)
    
    private let useCase: AuthUseCase
    
    var screenTitle: String {
        authType.rawValue.capitalized
    }
    
    var toggleButtonLabel: String {
        authType.toggleButtonLabel
    }
    
    init(authType: AuthType, useCase: AuthUseCase) {
        self.useCase = useCase
        self.authType = authType
    }
    
    func onSubmitTappedShouldNavigate() -> Bool {
        do {
            switch authType {
            case .login:
                let credential = try useCase.login(userName: userName, password: password)
                try useCase.saveCredential(credential)
                return true
            case .register:
                try useCase.register(userName: userName, password: password)
                let alertData = AlertData(
                    title: "Registration Succes!",
                    message: "You have successfully registered, please login",
                    actionLabel: "Login",
                    action: { [weak self] in
                        self?.authType = .login
                    })
                displayAllert(alertData)
            }
        } catch {
            let alertData = AlertData(
                title: "Authentication Failed",
                message: error.localizedDescription,
                actionLabel: "Retry",
                action: nil
            )
            displayAllert(alertData)
        }
        return false
    }
    
    func toggleAuthType() {
        if case .login = authType {
            authType = .register
            return
        }
        authType = .login
    }
    
    private func displayAllert(_ message: AlertData) {
        shouldDisplayAlert = true
        alertMessage = message
    }
}

struct AlertData {
    let title: String
    let message: String
    let actionLabel: String
    let action: (() -> Void)?
}
