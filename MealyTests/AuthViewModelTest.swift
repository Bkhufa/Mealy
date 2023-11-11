//
//  AuthViewModelTest.swift
//  MealyTests
//
//  Created by Bryan Khufa on 11/11/23.
//

import XCTest
@testable import Mealy

final class AuthViewModelTest: XCTestCase {
    
    var useCase: MockAuthUseCase!

    override func setUpWithError() throws {
        useCase = MockAuthUseCase()
    }

    override func tearDownWithError() throws {
        useCase = nil
    }

    func testinitialState_startWithLogin() {
        let sut = DefaultAuthViewModel(authType: .login, useCase: useCase)
        
        XCTAssertEqual(sut.authType, .login)
        XCTAssertEqual(sut.screenTitle, "Login")
        XCTAssertEqual(sut.toggleButtonLabel, "Didn't have an account yet? Register now!")
    }

    func testinitialState_startWithRegister() {
        let sut = DefaultAuthViewModel(authType: .register, useCase: useCase)
        
        XCTAssertEqual(sut.authType, .register)
        XCTAssertEqual(sut.screenTitle, "Register")
        XCTAssertEqual(sut.toggleButtonLabel, "Already have an account? Login here!")
    }
    
    func testChangeAuthType_fromRegister_toLogin() {
        let sut = DefaultAuthViewModel(authType: .register, useCase: useCase)
        
        sut.toggleAuthType()

        XCTAssertEqual(sut.authType, .login)
        XCTAssertEqual(sut.screenTitle, "Login")
        XCTAssertEqual(sut.toggleButtonLabel, "Didn't have an account yet? Register now!")

    }
    
    func testChangeAuthType_fromLogin_toRegister() {
        let sut = DefaultAuthViewModel(authType: .login, useCase: useCase)
        
        sut.toggleAuthType()
        
        XCTAssertEqual(sut.authType, .register)
        XCTAssertEqual(sut.screenTitle, "Register")
        XCTAssertEqual(sut.toggleButtonLabel, "Already have an account? Login here!")
    }
    
    func testLogin_success() {
        let sut = DefaultAuthViewModel(authType: .login, useCase: useCase)
        
        XCTAssertFalse(useCase.loginCalled)
        XCTAssertFalse(useCase.saveCredentialsCalled)
        
        sut.userName = "Bryan"
        sut.password = "123"
        let shouldNavigate = sut.authenticateShouldNavigate()
        
        XCTAssertTrue(shouldNavigate)
        XCTAssertTrue(useCase.loginCalled)
        XCTAssertTrue(useCase.saveCredentialsCalled)
    }
    
    func testLogin_failed() {
        let sut = DefaultAuthViewModel(authType: .login, useCase: useCase)
        
        XCTAssertFalse(useCase.loginCalled)
        XCTAssertFalse(useCase.saveCredentialsCalled)
        
        sut.userName = "Bryan"
        sut.password = "123"
        useCase.shouldFail = true
        let shouldNavigate = sut.authenticateShouldNavigate()
        
        XCTAssertFalse(shouldNavigate)
        XCTAssertTrue(useCase.loginCalled)
        XCTAssertFalse(useCase.saveCredentialsCalled)
        XCTAssertTrue(sut.shouldDisplayAlert)
        XCTAssertEqual(sut.alertMessage.title, "Authentication Failed")
    }
    
    func testRegister_success() {
        let sut = DefaultAuthViewModel(authType: .register, useCase: useCase)
        
        XCTAssertFalse(useCase.registerCalled)
        
        sut.userName = "Bryan"
        sut.password = "123"
        sut.authenticateShouldNavigate()
        
        XCTAssertTrue(useCase.registerCalled)
        XCTAssertTrue(sut.shouldDisplayAlert)
        XCTAssertEqual(sut.alertMessage.title, "Registration Succes!")
    }
    
    func testRegister_failed() {
        let sut = DefaultAuthViewModel(authType: .register, useCase: useCase)
        
        XCTAssertFalse(useCase.registerCalled)
        
        sut.userName = "Bryan"
        sut.password = "123"
        useCase.shouldFail = true
        sut.authenticateShouldNavigate()
        
        XCTAssertTrue(useCase.registerCalled)
        XCTAssertTrue(sut.shouldDisplayAlert)
        XCTAssertEqual(sut.alertMessage.title, "Authentication Failed")
    }
}
