//
//  MockSignUpWebService.swift
//  UTestAppTests
//
//  Created by Denis Yaremenko on 4/28/21.
//

import Foundation
@testable import UTestApp

class MockSignUpWebService: SignUpWebServiceProtocol {
    
    var isSignupMethodCalled: Bool = false
    var shouldReturnError: Bool = false
    
    func signup(withForm formModel: SignupFormRequestModel, completion: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        isSignupMethodCalled = true
        
        if shouldReturnError {
            completion(nil, SignupError.failedRequest(description: "Sign up request was not successfull"))
        } else {
            let responseModel = SignupResponseModel(status: "Ok")
            completion(responseModel, nil)
        }
    }
}
