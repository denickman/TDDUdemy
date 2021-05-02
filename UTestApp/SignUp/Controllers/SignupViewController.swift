//
//  ViewController.swift
//  UTestApp
//
//  Created by Denis Yaremenko on 4/27/21.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTestField: UITextField!
    @IBOutlet weak var emailTestField: UITextField!
    @IBOutlet weak var passwordTestField: UITextField!
    @IBOutlet weak var repeatPasswordTestField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var signUpPresenter: SignUpPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if signUpPresenter == nil {
            // you can also get launch arguments environment from UITests that you have set in test metod
            // see app.launchEnvironment = ["signUpUrl"]
            let signupURL = ProcessInfo.processInfo.environment["signUpUrl"] ?? SignupConstants.pathURLStrin
            
            let signupModelValidator = SignUpFormModelValidator()
            
            let webService = SignupWebService(urlString: signupURL)
            
            signUpPresenter = SignupPresenter(formModelValidator: signupModelValidator, webService: webService, delegate: self)
        }
        
        #if DEBUG
        // here is an -skipsurveyhere argument that was passed from the uitest
        // see app.launchArguments in SignUpFlowUITests
        // you can also set here a breakpoint and po in command line
        // po CommandLine.arguments 
        if CommandLine.arguments.contains("-skipSurveyHere") {
            print("Skipping survey page")
        }
        #endif
        
        // Another way for getting arguments
        // Process Info contains much more functionality and it is more advanced
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-skipSurvey") {
            print("Skipping survey page")
        }
        #endif
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let signUpFormModel = SignupFormModel.init(firstName: userFirstNameTextField.text ?? "", lastName: userLastNameTestField.text ?? "", email:  emailTestField.text ?? "", password: passwordTestField.text ?? "", repeatPassword: repeatPasswordTestField.text ?? "")
        
        signUpPresenter?.processUserSignup(formModel: signUpFormModel)
    }
    
    @IBAction func openButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let sut = storyboard.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else { return }
        // set accesibility identifier programatically here
        sut.view.accessibilityIdentifier = "SecondViewController"
        present(sut, animated: false, completion: nil)
    }
}

extension SignupViewController: SignUpViewDelegateProtocol {
    
    func successfulSignUp() {
        let alert = UIAlertController(title: "Success", message: "The sign up operation was successful", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            // add accesibility identifier for connecting UITests
            // See XCTAssertTrue(app.alerts["successAlertDialog"] in SignUPFlowUITests
            alert.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func errorHandler(error: SignupError) {
        let alert = UIAlertController(title: "Error",
                                      message: "\(error.errorDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            // add accesibility identifier for connecting UITests
            // See XCTAssertTrue(app.alerts["errorAlertDialog"] in SignUPFlowUITests
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert, animated: true, completion: nil)
        }
    }
}
