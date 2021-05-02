//
//  SignUpViewControllerTests.swift
//  UTestAppTests
//
//  Created by Denis Yaremenko on 4/29/21.
//

import XCTest
@testable import UTestApp

class SignUpViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: SignupViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SignupViewController") as? SignupViewController
        sut?.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        sut = nil
    }
    
    func testSignUpViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        
        let firstNameTextField = try XCTUnwrap(sut.userFirstNameTextField, "The first name textfield is not connected to an IBOutlet")
        
        XCTAssertEqual(firstNameTextField.text, "", "First name text field was not empty when the view controller initially loaded")
        
        let secondNameTextField = try XCTUnwrap(sut.userLastNameTestField, "The second name textfield is not connected to an IBOutlet")
        
        XCTAssertEqual(secondNameTextField.text, "", "Second name text field was not empty when the view controller initially loaded")
 
        XCTAssertEqual(sut.userLastNameTestField.text, "", "Last name text field was not empty when the view controller initially loaded")
        
        XCTAssertEqual(sut.emailTestField.text, "", "Email text field was not empty when the view controller initially loaded")
        
        XCTAssertEqual(sut.passwordTestField.text, "", "Password text field was not empty when the view controller initially loaded")
        
        XCTAssertEqual(sut.repeatPasswordTestField.text, "", "Repeat password text field was not empty when the view controller initially loaded")
    }
    
    func testViewController_WhenCreated_HasSignUpButtonAndAction() throws {
        //Arrange
        let signupButton: UIButton = try XCTUnwrap(sut.signupButton, "SignUp button is not connected")
        
        // Act
        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "Signup button does not have any actions assigned to it")
        
        // Assert
        XCTAssertEqual(signupButtonActions.count, 1)
        
        XCTAssertEqual(signupButtonActions.first, "signUpButtonTapped:", "There is no actions with a name signupButtonTapped assigned to signup button")
    }
    
    func testViewController_WhenSignUpButtonTapped_InvokesSignupProcess() {
        
        let mockSignUpModelValidator = MockSignupModelValidator()
        let mockSignupWebService = MockSignUpWebService()
        let mockSignUpView = MockSignUpViewDelegate()
//
        let mockSignUpPresenter = MockSignUpPresenter(formModelValidator: mockSignUpModelValidator, webService: mockSignupWebService, delegate: mockSignUpView)
        
        sut.signUpPresenter = mockSignUpPresenter

        sut.signupButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(mockSignUpPresenter.processUserSignupCalled, "The processusersignup() method was not called on a Presenter object when the signup button was tapped in a signUpViewController")
    }
}
