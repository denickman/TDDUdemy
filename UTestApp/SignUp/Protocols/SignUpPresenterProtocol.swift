//
//  SignUpPresenterProtocol.swift
//  UTestApp
//
//  Created by Denis Yaremenko on 4/29/21.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {
    
    init(formModelValidator: SignUpModelValidatorProtocol,
         webService: SignUpWebServiceProtocol,
         delegate: SignUpViewDelegateProtocol)
    
    func processUserSignup(formModel: SignupFormModel)
}
