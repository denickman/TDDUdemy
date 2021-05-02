//
//  SignupWebService.swift
//  UTestApp
//
//  Created by Denis Yaremenko on 4/28/21.
//

import Foundation

struct SignupResponseModel: Decodable {
    let status: String
}

enum SignupError: Error, Equatable {
    
    case invalidResponseModelParsing
    case invalidRequestURLString
    case failedRequest(description: String)
    
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case passwordsDoNotMatch
    
    var errorDescription: String? {
        switch self {
        
        case .invalidResponseModelParsing, .invalidRequestURLString:
            return ""
            
        case .invalidFirstName:
            return "invalid first name"
            
        case .invalidLastName:
            return "invalid last name"
            
        case .invalidEmail:
            return "invalid email"
            
        case .invalidPassword:
            return "Invalid password"
            
        case .passwordsDoNotMatch:
            return "Password do not match"
            
        case .failedRequest(let description):
            return description
        }
    }
}

class SignupWebService: SignUpWebServiceProtocol {
    
    private var urlString: String
    private var urlSession: URLSession
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signup(withForm formModel: SignupFormRequestModel, completion: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil, SignupError.invalidRequestURLString)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = try? JSONEncoder().encode(formModel)
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            
            // if url request fails
            if let requestError = error {
                completion(nil, SignupError.failedRequest(description: requestError.localizedDescription))
                return
            }
            
            if let data = data,
               let signupResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                completion(signupResponseModel, nil)
            } else {
                completion(nil, SignupError.invalidResponseModelParsing)
            }
        }
        
        dataTask.resume()
    }
}
