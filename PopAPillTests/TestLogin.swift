//
//  TestLogin.swift
//  PopAPillTests
//
//  Created by jossyris on 3/20/25.
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
  
  
  
    
    //Testing user: for an empty password
    func testEmptyPassword(){
        viewModel.email = "email2x@gmail.com"
        viewModel.password = ""
        let result = viewModel.validate()
        
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Fill in all fields")
    }
    
    //Testing user: for a short password
    func testShortPassword(){
        viewModel.email = "email2z@gmail.com"
        viewModel.password = "Pass"
        let result = viewModel.validate()
        
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Password must be at least 6 characters long")
    }
    
    //Testing user: for an empty email
    func testEmptyEmail(){
        viewModel.email = ""
        viewModel.password = "Testingpassword1!"
        let result = viewModel.validate()
        
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Fill in all fields")
    }
    
    //Testing user: for an a missing "@" in email
    func testEmptyEmailWithoutAt(){
        viewModel.email = "email2xgmail.com"
        viewModel.password = "Testingpassword1!"
        let result = viewModel.validate()
        
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Enter a valid email")
    }
    
    //Testing user: for an a missing "." in email
    func testEmptyEmailWithoutDot(){
        viewModel.email = "email2x@gmailcom"
        viewModel.password = "Testingpassword1!"
        let result = viewModel.validate()
        
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Enter a valid email")
    }
        
    //Testing user: for an empty password and email
    func testAllInvalidFields(){
        viewModel.email = ""
        viewModel.password = ""
        let result = viewModel.validate()
        
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Fill in all fields")
    }
    
    
    //Testing user: has valid email and password
    func testAllFields(){
        viewModel.email = "email2x@gmail.com"
        viewModel.password = "Testingpassword1!"
        let result = viewModel.validate()
        
        XCTAssertTrue(result)
        XCTAssertEqual(viewModel.errorM, "")
       
    }



}

    
    

