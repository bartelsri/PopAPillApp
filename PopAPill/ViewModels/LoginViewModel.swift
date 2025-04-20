//
//  LoginViewViewModel.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//
import FirebaseAuth
import Foundation

//viewModel for user login
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var providerID = ""
    @Published var errorM = ""         //error message
    @Published var showError = false //flag to show error message
    @Published var isProvider = false //checks whether provider or user
    @Published var isLoggedIn = false // flag for login success
    
    init() {
    }
    
    //Function to handle user input before an attemptt\
    func login(onSuccess: @escaping () -> Void)  {
        
        guard validate(isProvider: isProvider) else {
            showError = true
            return
        }
        //login for user with Firebase Aurh
        Auth.auth().signIn(withEmail: email, password: password){ user, error in
            
            if let error = error as NSError? {
                let errorCode = AuthErrorCode(rawValue: error.code)
                //Handles different scenarios
                switch errorCode {
                case .userNotFound:
                    self.errorM = "Invalid Email"
                case .wrongPassword:
                    self.errorM = "Incorrect password"
                    
                default:
                    self.errorM = "\(error.localizedDescription)"
                }
                //Display error
                self.showError = true
            } else {
                //Else user has successfuly logged
                self.errorM = ""
                self.showError = false
                
                //save role to userDefaults
                UserDefaults.standard.set(self.isProvider, forKey: "userRole")
                //triger navigation
                //self.isLoggedIn = true
                onSuccess() //triggers navigation
            }
        }
        
    }
    
    
    //Validate a user before logging in
    func validate(isProvider: Bool = false) -> Bool {
        errorM = ""
        //Ensurs email and password aren't empty or have white space
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorM = "Fill in all fields"
            return false
        }
        
        //regular expression for email format
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard emailPredicate.evaluate(with: email) else {
            errorM = "Enter a valid email"
            return false
        }
        //Ensure password meets a required length
        guard password.count >= 6 else {
            errorM = "Password must be at least 6 characters long"
            return false
        }

        //check that provider ID is given
        if isProvider{
            guard !providerID.trimmingCharacters(in: .whitespaces).isEmpty else{
                errorM = "Provider ID required"
                return false
            }
        }
        return true
    }
}
