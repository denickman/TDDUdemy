//
//  SignupPresenterTests.swift
//  UTestAppTests
//
//  Created by Denis Yaremenko on 4/28/21.
//

import XCTest
@testable import UTestApp

class SignupPresenterTests: XCTestCase {
    
    var signupFormModel: SignupFormModel!
    var mockSignupModelValidator: MockSignupModelValidator!
    var mockSignUpWebService: MockSignUpWebService!
    var sut: SignupPresenter!
    var mockSignUpViewDelegate: MockSignUpViewDelegate!
    
    override func setUpWithError() throws {
        signupFormModel = SignupFormModel(firstName: "Den", lastName: "Yarem", email: "yaremdennis@gmail.com", password: "12345678", repeatPassword: "12345678")
        
        mockSignupModelValidator = MockSignupModelValidator()
        mockSignUpWebService = MockSignUpWebService()
        mockSignUpViewDelegate = MockSignUpViewDelegate()
        
        sut = SignupPresenter(formModelValidator: mockSignupModelValidator,
                              webService: mockSignUpWebService,
                              delegate: mockSignUpViewDelegate)
    }
    
    override func tearDownWithError() throws {
        signupFormModel = nil
        mockSignupModelValidator = nil
        mockSignUpWebService = nil
        mockSignUpViewDelegate = nil
        sut = nil
    }
    
    func testSignUpPresenter_WhenInformationProvided_WillValidateEachProperty() {
        // Arrange
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name is not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last name is not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailFormatValidated, "Email is not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password is not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordEqualityValidated, "Passwords do not match")
    }
    
    func testSignUpPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        
        // Arrange
        sut.processUserSignup(formModel: signupFormModel)
        
        // Act
        
        // Assert
        XCTAssertTrue(mockSignUpWebService.isSignupMethodCalled, "The signup method was not called in the SignUpWebService class")
    }
    
    func testSignUpPresenter_WhenSignupOperationSuccessful_CallsSuccessOnViewDelegate() {
        // Arrange
        let myExpectation = expectation(description: "Expected the successfulSignUp() method to be called")
        
        mockSignUpViewDelegate.expectation = myExpectation
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        // Assert
        XCTAssertEqual(mockSignUpViewDelegate.successfulSignUpCounter, 1, "the successfulSignUp() method was called more than one time")
    }
    
    func testSignUpPresenter_WhenSignUpOperationFails_ShouldCallErrorOnDelegate() {
        let errorHandlerExpectation = expectation(description: "Expected the errorHander() method to be called")
        mockSignUpViewDelegate.expectation = errorHandlerExpectation
        mockSignUpWebService.shouldReturnError = true
        
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [errorHandlerExpectation], timeout: 5.0)
        
        XCTAssertEqual(mockSignUpViewDelegate.successfulSignUpCounter, 0)
        XCTAssertEqual(mockSignUpViewDelegate.errorHandlerCounter, 1)
        XCTAssertNotNil(mockSignUpViewDelegate.signupError)
    }
}
