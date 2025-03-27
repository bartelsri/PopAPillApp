//
//  TestLogin.swift
//  PopAPillTests
//
//  Created by Stephanie on 3/26/25.
//

import XCTest
@testable import PopAPill


class TestLogin: XCTestCase {

    var viewModel: LoginViewModel!


    override func setUp() {
        super.setUp( )
        viewModel = LoginViewModel()
    }
    override func tearDown() {
        viewModel = nil
        super.tearDown()
       }




    //Testing provider: for an empty password
    func testEmptyPassword(){
        viewModel.email = "provideremail@gmail.com"
        viewModel.password = ""
        let result = viewModel.validate(isProvider: true)

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Fill in all fields")
    }

    //Testing provider: for a short password
    func testShortPassword(){
        viewModel.email = "provideremail@gmail.com"
        viewModel.password = "Pass"
        let result = viewModel.validate(isProvider: true)

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Password must be at least 6 characters long")
    }

    //Testing provider: for an empty email
    func testEmptyEmail(){
        viewModel.email = ""
        viewModel.password = "Testingpassword2!"
        let result = viewModel.validate(isProvider: true)

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Fill in all fields")
    }

    //Testing provider: for an a missing "@" in email
    func testEmptyEmailWithoutAt(){
        viewModel.email = "provideremailgmail.com"
        viewModel.password = "Testingpassword2!"
        let result = viewModel.validate(isProvider: true)

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Enter a valid email")
    }

    //Testing provider: for an a missing "." in email
    func testEmptyEmailWithoutDot(){
        viewModel.email = "provideremail@gmailcom"
        viewModel.password = "Testingpassword2!"
        let result = viewModel.validate(isProvider: true)

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Enter a valid email")
    }

    //Testing provider: for an empty providerID
    func testMissingProviderID(){
        viewModel.email = "provideremail@gmail.com"
        viewModel.password = "Testingpassword2!"
        viewModel.providerID = ""
        let result = viewModel.validate(isProvider: true)

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Provider ID is required")
    }

    //Testing provider: for an empty password and email
    func testAllInvalidFields(){
        viewModel.email = ""
        viewModel.password = ""
        let result = viewModel.validate(isProvider: true)

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Fill in all fields")
    }


    //Testing provider: has valid email, password, and a provider ID
    func testAllFields(){
        viewModel.email = "provideremail@gmail.com"
        viewModel.password = "Testingpassword2!"
        viewModel.providerID = "12345"
        let result = viewModel.validate(isProvider: true)

        XCTAssertTrue(result)
        XCTAssertEqual(viewModel.errorM, "")

    }

}