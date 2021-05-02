//
//  SignUpViewDelegateProtocol.swift
//  UTestApp
//
//  Created by Denis Yaremenko on 4/28/21.
//

import Foundation

protocol SignUpViewDelegateProtocol: class {
    func successfulSignUp()
    func errorHandler(error: SignupError)
}
