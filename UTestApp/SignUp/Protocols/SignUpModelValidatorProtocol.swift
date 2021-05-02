//
//  SignUpModelValidatorProtocol.swift
//  UTestApp
//
//  Created by Denis Yaremenko on 4/28/21.
//

import Foundation

protocol SignUpModelValidatorProtocol: class {
    
    func isFirstNameValid(firstName: String) -> Bool
    
    func isLastNameValid(lastName: String) -> Bool

    func isValidEmailFormat(email: String) -> Bool
    
    func isPasswordValid(password: String) -> Bool
 
    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool
    
}
