//
//  SignUpFormModelValidator.swift
//  UTestAppTests
//
//  Created by Denis Yaremenko on 4/27/21.
//

import XCTest
@testable import UTestApp

class SignUpFormModelValidatorTests: XCTestCase {
    
    var sut: SignUpFormModelValidator!
    
    override func setUpWithError() throws {
        sut = SignUpFormModelValidator()
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSignUpFormModelValidator_WhenValidFirstNameIsProvided_ShouldReturnTrue() {
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Den")
        
        // Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have returned TRUE for a valid first name but returned FALSE")
    }
    
    
    func testSignUpFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnedFalse() {
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "s")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a frist name that is shorter than \(SignupConstants.firstNameMinimumLenght) characters but it has returned TRUE")
    }
    
    func testSignUpFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        let isFirstNameValid = sut.isFirstNameValid(firstName: "SergeySergey")
        
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a frist name that is longer than \(SignupConstants.firstNameMaximumLenght) characters but it has returned TRUE")
    }
    
    func testSignUpFormModelValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        let isPasswordValid = sut.isPasswordValid(password: "12")
        
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is shorter than \(SignupConstants.passwordMinLenght) but it has returned TRUE")
    }
    
    func testSignUpFormModelValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        let isPasswordValid = sut.isPasswordValid(password: "1234567890987654321")
        
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is longer than \(SignupConstants.passwordMaxLenght) but it has returned TRUE")
    }
    
    func testSignUpFormModelValidator_WhenEqualPasswordsProvided_ShouldReturnTrue() {
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword: "12345678")
        
        XCTAssertTrue(doPasswordsMatch, "The doPasswordMatch() should have returned TRUE for matching passwords but it has returned FALSE")
    }
    
    func testSignUpFormModelValidator_WhenNotMatchingPasswordsProvided_ShouldReturnFalse() {
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword: "1234567")
        
        XCTAssertFalse(doPasswordsMatch, "The doPasswordMatch() should have returned FALSE for passwords that do not match but it has returned TRUE")
    }
}
