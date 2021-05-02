//
//  SignupFormRequestModel.swift
//  UTestApp
//
//  Created by Denis Yaremenko on 4/28/21.
//

import Foundation

struct SignupFormRequestModel: Encodable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
}
