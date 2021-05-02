//
//  ProgramaticallyLoadViewControllerTests.swift
//  UTestAppTests
//
//  Created by Denis Yaremenko on 4/29/21.
//

import XCTest
@testable import UTestApp

class ProgramaticallyLoadViewControllerTests: XCTestCase {
    
    var sut: ProgramaticallyLoadViewController!

    override func setUpWithError() throws {
        sut = ProgramaticallyLoadViewController()
        sut.loadViewIfNeeded()    
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


}
