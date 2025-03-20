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
    
    func testEmptyPassword(){
        viewModel.email = "email2x@gmail.com"
        viewModel.password = ""
        let result = viewModel.validate()
        
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorM, "Fill in all fields")
    }



}
