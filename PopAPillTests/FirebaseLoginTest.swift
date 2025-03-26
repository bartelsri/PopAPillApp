//
//  FirebaseLoginTest.swift
//  PopAPill
//
//  Created by jossyris on 3/25/25.
//


import XCTest
import FirebaseAuth
import FirebaseCore
@testable import PopAPill

class FirebaseLoginTest: XCTestCase {
    
    var viewModel: LoginViewModel!
    
    let testEmail = ""
    let testPassword = ""
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
        
        
    }
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Test successful login
    func testSuccessfulLogin() {
        
        viewModel.email = "bedbottle@gmail.com"
        viewModel.password = "Jossyris1!"
        
        viewModel.login { success, error in
            if success {
                XCTAssertNil(error, "Success for valid login")
            } else {
                XCTFail("Login failed with error: \(error?.localizedDescription ?? "Invalid email or password")")
            }
        }
    }
    // Test invalid email login
    func testInvalidEmailLogin() {
        
        viewModel.email = "beddddddd@gmail.com"
        viewModel.password = "Jossyris1!"
        
        viewModel.login { success, error in
            XCTAssertFalse(success, "Invalid email")
            XCTAssertNil(error, "return error for invalid email")
        }
        
    }
    // Test invalid password login
    func testInvalidPasswordLogin() {
        
        viewModel.email = "bedbottle@gmail.com"
        viewModel.password = "Jossyrifergs1!"
        
        viewModel.login { success, error in
            XCTAssertFalse(success, "Invalid password")
            XCTAssertNil(error, "return error for invalid password")
        }
        
    }
    // Test login with invalid password and email
    func testLoginWithInvalidCredentials() {
        
        viewModel.email = "invalid@example.com"
        viewModel.password = "wrongpassword"
        
        viewModel.login { success, error in
            XCTAssertFalse(success, "Invalid")
            XCTAssertTrue(self.viewModel.errorM.contains("Authentication failed"), "Failed")
        }
    }
}


extension LoginViewModel {
    func login(completion: @escaping (Bool, Error?) -> Void) {
        guard validate() else {
            completion(false, nil)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.errorM = "Authentication failed: \(error.localizedDescription)"
                completion(false, error)
                return
            }
            // Successful login
            self.errorM = ""
            completion(true, nil)
        }
    }
}
