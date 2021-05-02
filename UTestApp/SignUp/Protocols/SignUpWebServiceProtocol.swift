//
//  SignUpWebServiceProtocol.swift
//  UTestApp
//
//  Created by Denis Yaremenko on 4/28/21.
//

import Foundation

protocol SignUpWebServiceProtocol: class {
    func signup(withForm formModel: SignupFormRequestModel, completion: @escaping (SignupResponseModel?, SignupError?) -> Void)
}
