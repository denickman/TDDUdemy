//
//  MockSignUpPresenter.swift
//  UTestAppTests
//
//  Created by Denis Yaremenko on 4/29/21.
//

import Foundation
@testable import UTestApp

class MockSignUpPresenter: SignUpPresenterProtocol {
    
    var processUserSignupCalled: Bool = false
    
    required init(formModelValidator: SignUpModelValidatorProtocol,
         webService: SignUpWebServiceProtocol,
         delegate: SignUpViewDelegateProtocol) {
        
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        processUserSignupCalled = true
    }
  
}
