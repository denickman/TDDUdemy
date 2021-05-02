//
//  UploadSignUpViewControllerTests.swift
//  UTestAppTests
//
//  Created by Denis Yaremenko on 4/29/21.
//

import XCTest
@testable import UTestApp

class UploadSignUpViewControllerTests: XCTestCase {
    
    var sut: SignupViewController!

    override func setUpWithError() throws {
        
        // via storyboard
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SignupViewController") as? SignupViewController
        
        sut.loadViewIfNeeded() // trigger view did load method as well
        
        
    
    }

    override func tearDownWithError() throws {
        
    }

}
