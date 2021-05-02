//
//  MockSignUpViewDelegate.swift
//  UTestAppTests
//
//  Created by Denis Yaremenko on 4/28/21.
//

import Foundation
import XCTest
@testable import UTestApp

class MockSignUpViewDelegate: SignUpViewDelegateProtocol {
    
    var expectation: XCTestExpectation?
    var successfulSignUpCounter = 0
    var errorHandlerCounter = 0
    var signupError: SignupError?
    
    func successfulSignUp() {
        successfulSignUpCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignupError) {
        signupError = error
        errorHandlerCounter += 1
        expectation?.fulfill()
    }
}
