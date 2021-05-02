//
//  SignUpFormModelValidator.swift
//  UTestApp
//
//  Created by Denis Yaremenko on 4/27/21.
//

import Foundation

class SignUpFormModelValidator: SignUpModelValidatorProtocol {
    
    func isFirstNameValid(firstName: String) -> Bool {
        var returnValue = true
        
        if firstName.count < SignupConstants.firstNameMinimumLenght || firstName.count > SignupConstants.firstNameMaximumLenght {
            returnValue = false
        }

        return returnValue
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        
        var returnValue = true

        if lastName.count < SignupConstants.lastNameMinLenght || lastName.count > SignupConstants.lastNameMaxLenght {
            returnValue = false
        }

        return returnValue
    }

    func isValidEmailFormat(email: String) -> Bool {
        // see Lesson 27
        return NSPredicate(format: "SELF MATCHES %@","").evaluate(with: email)
    }
    
    func isPasswordValid(password: String) -> Bool {
        // see Lesson 27
        return NSPredicate(format: "SELF MATCHES %@", "").evaluate(with: password)
    }
 
    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool {
        return password == repeatPassword
    }
}
