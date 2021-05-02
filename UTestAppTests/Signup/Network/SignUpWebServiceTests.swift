//
//  SignUpWebServiceTests.swift
//  UTestAppTests
//
//  Created by Denis Yaremenko on 4/28/21.
//

import XCTest
@testable import UTestApp

class SignUpWebServiceTests: XCTestCase {
    
    var sut: SignupWebService!
    var signFormRequestModel: SignupFormRequestModel!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral // does not use a persistance store for cookies, cache
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.pathURLString, urlSession: urlSession)
        
        signFormRequestModel = SignupFormRequestModel(firstName: "Den",
                                                            lastName: "Yarem",
                                                            email: "yaremdennis@gmail.com", password: "12345678")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        signFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnsSuccess() {

        // Arrange
        let jsonResponseString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonResponseString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Sign up web service response expectation")
        
        // Act
        sut.signup(withForm: signFormRequestModel) {
            (signupResponseModel, error) in
            // Assert
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    //Bad response here
    func testSignUpWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        
        let jsonErrorString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonErrorString.data(using: .utf8)
        
        let expectation = self.expectation(description: "SignUp() method expectation for a response that contains a different JSON Structure")
        
        sut.signup(withForm: signFormRequestModel) { (response, error) in
            // Assert
            // "{\"status\":\"ok\"}"
            XCTAssertNil(response, "The response model for a request containing unknown response should have been nil")
            XCTAssertEqual(error, SignupError.invalidResponseModelParsing, "The signup() metho did not return expected error")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 3)
    }
    
    // check if string for creating URL is not valid
    func testSignUpWebService_WhenEmptyURLStringProvided_ReturnsError() {
        // Arrange
        
        let expectation = self.expectation(description: "An empty request URL string expectation")
        
        sut = SignupWebService(urlString: "")
        // here we do not need to use url session argument because we do not send http url request here
        
        sut.signup(withForm: signFormRequestModel) { (response, error) in
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "The signup() method did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(response, "When an invaidRequestURLString takes place, the response model must be nil")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    // Testing error if response is fails - return error instead of response or data
    func testSignUpWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        let expectation = self.expectation(description: "A Failed Request expectation")
        
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = SignupError.failedRequest(description: errorDescription)
        
        sut.signup(withForm: signFormRequestModel) { (response, error) in
//            XCTAssertEqual(error, SignUpError.failedRequest(description: errorDescription), "The signup method did not return an expected error for the Failed Request")
//            XCTAssertEqual(error?.localizedDescription, errorDescription)
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
}
