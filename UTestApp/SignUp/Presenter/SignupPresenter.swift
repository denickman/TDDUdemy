//
//  SignupPresenter.swift
//  UTestApp
//
//  Created by Denis Yaremenko on 4/28/21.
//

import Foundation

class SignupPresenter: SignUpPresenterProtocol {
    
    private var formModelValidator: SignUpModelValidatorProtocol
    private var webService: SignUpWebServiceProtocol
    private weak var delegate: SignUpViewDelegateProtocol?
    
   required init(formModelValidator: SignUpModelValidatorProtocol,
         webService: SignUpWebServiceProtocol,
         delegate: SignUpViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.webService = webService
        self.delegate = delegate
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        
        if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
            self.delegate?.errorHandler(error: .invalidFirstName)
            return 
        }
        
        if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
            self.delegate?.errorHandler(error: .invalidLastName)
            return
        }
        
//        if !formModelValidator.isValidEmailFormat(email: formModel.email) {
//            self.delegate?.errorHandler(error: .invalidEmail)
//            return
//        }
//
//        if !formModelValidator.isPasswordValid(password: formModel.password) {
//            return
//        }
        
        if !formModelValidator.doPasswordsMatch(password: formModel.password, repeatPassword: formModel.repeatPassword) {
            return
        }
        
        let requestModel = SignupFormRequestModel(firstName: formModel.firstName,
                                                  lastName: formModel.lastName,
                                                  email: formModel.email,
                                                  password: formModel.password)
        
        webService.signup(withForm: requestModel) { [weak self] (response, error) in
            
            guard let self = self else { return }
            
            if let _ = response {
                self.delegate?.successfulSignUp()
                return
            }
            
            if let error = error {
                self.delegate?.errorHandler(error: error)
                return 
            }
            
        }
    }
}
