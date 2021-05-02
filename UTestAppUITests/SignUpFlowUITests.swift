//
//  UTestAppUITests.swift
//  UTestAppUITests
//
//  Created by Denis Yaremenko on 4/27/21.
//

import XCTest

class SignUpFlowUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var firstName: XCUIElement!
    private var lastName: XCUIElement!
    private var email: XCUIElement!
    private var password: XCUIElement!
    private var repeatPassword: XCUIElement!
    private var signupButton: XCUIElement!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        // po app - will print out the description of app object that contains an entire tree currently loaded tree elements
        
        // before app.launch() set arguments here
        // pass launch arguments
        // skip a survey page
        app.launchArguments = ["-skipSurveyHere", "-debugServer,", "-f#Denmark"]
        
        app.launchEnvironment = ["signUpUrl" : "http://appsdeveloperblog.com/api/v2/signup-mock-service/users",
                                 "inAppPurchasesEnabled" : "true",
                                 "inAppAdsEnabled":"true"]
        
        // see SignUp ViewControlelr for arguemtns
        app.launch()
        
        // access via accesibility indentifier - you can set it through the accesibility inspector in storyboard/xib on 4th item in top list
        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        email = app.textFields["emailTextField"]
        password = app.secureTextFields["passwordTextField"]
        repeatPassword = app.secureTextFields["repeatPasswordTextField"]
        signupButton = app.buttons["signupButton"]
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func testSignUpViewController_WhenViewLoaded_RequiredUIElementsAreEnabled() throws {
        
        XCTAssertTrue(firstName.isEnabled, "First name UITextField is not enabled for user interactions")
        
        XCTAssertTrue(lastName.isEnabled, "Last name UITextField is not enabled for user interactions")
        
        XCTAssertTrue(email.isEnabled, "Email UITextField is not enabled for user interactions")
        
        XCTAssertTrue(password.isEnabled, "Password UITextField is not enabled for user interactions")
        
        XCTAssertTrue(repeatPassword.isEnabled, "Repeat Password UITextField is not enabled for user interactions")
        
        XCTAssertTrue(signupButton.isEnabled, "The Sign UP Button is not enabled for user interactions")
    }
    
    func testViewController_WhenInvalidFormSubmitted_PresentsErrorAlertDialog() {
        
        // If you want to see test report need to click on this diamond and select ->
        // Jump to Report - you can see screenshots in every line
        
        /*
         Recently we found a hack to make solution from accepted answer persistent. To disable Simulator setting: 'Hardware -> Keyboard -> Connect hardware keyboard' from command line one should write:
         
         defaults write com.apple.iphonesimulator ConnectHardwareKeyboard 0
         
         It will not affect a simulator which is running - you need to restart simulator or start a new one to make that setting have its effect.
         */
        
        firstName.tap() // tap on firstNameTextField
        firstName.typeText("S")
        
        lastName.tap()
        lastName.typeText("K")
        
        email.tap()
        email.typeText("@")
        
        password.tap()
        password.typeText("123456")
        
        repeatPassword.tap()
        repeatPassword.typeText("123")
        
        signupButton.tap()
        
        // Manually create screenshot
        
        // If you want to see test report need to click on this diamond and select ->
        // Jump to Report - you can see screenshots in every line
        
        let emailTextFieldScreenshot = email.screenshot()
        let emailTextFieldAttachment = XCTAttachment(screenshot: emailTextFieldScreenshot)
        emailTextFieldAttachment.name = "Screenshot of Email TextField"
        emailTextFieldAttachment.lifetime = .keepAlways
        add(emailTextFieldAttachment) // add this attachment to the test report
        
        // make a full screenshot of screen
        //        let currentAppWindow = app.screenshot()
        // instead of using app.screenshot() you may use this
        let currentAppWindow = XCUIScreen.main.screenshot()
        let currentAppWindowAttachment = XCTAttachment(screenshot: currentAppWindow)
        currentAppWindowAttachment.name = "Sign Up Page Screenshot"
        currentAppWindowAttachment.lifetime = .keepAlways
        add(currentAppWindowAttachment) // add this attachment to the test report
        
        // Show Alert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1), "An Error Alert dialog was not presented when invalid signup form was submitted")
        
        // waitForExistence - very similar to expectations in Unit Tests
        // with this method I ask my test method to wait of certain amount of seconds to let the dialog alert appear and if the alert dialog is not appear until it expires then the test assertion will fail this test method
    }
    
    func testViewController_WhenValidFormSubmitted_PresentsSuccessAlertDialog() {
        
        firstName.tap()
        firstName.typeText("Sergey")
        
        lastName.tap()
        lastName.typeText("Kukoldov")
        
        email.tap()
        email.typeText("yaremdennis@gmail.com")
        
        password.tap()
        password.typeText("12345678")
        
        repeatPassword.tap()
        repeatPassword.typeText("12345678")
        
        signupButton.tap()
        
        // Show Alert
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 3), "A success alert dialog was not presented when valid signup form was submitted")
    }
    
    func testOneButton_WhenTapped_PresentsSecondViewController() throws {
        // you can set accesibility identifier in identity inspector in storyboard
        app.buttons["openSecondViewController"].tap()
        // get view of viewcontroller
        XCTAssertTrue(app.otherElements["SecondViewController"].waitForExistence(timeout: 1), "The signupviewcontroller was not presented when the create account was tapped")
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

