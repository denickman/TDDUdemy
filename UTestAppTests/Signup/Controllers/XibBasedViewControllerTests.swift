//
//  XibBasedViewControllerTests.swift
//  UTestAppTests
//
//  Created by Denis Yaremenko on 4/29/21.
//

import XCTest
@testable import UTestApp

class XibBasedViewControllerTests: XCTestCase {
    
    var sut: XibBasedViewController!

    override func setUpWithError() throws {
        // Using XIB
        sut = XibBasedViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


}
