//
//  LoginViewViewModel.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//
import FirebaseAuth
import Foundation
import FirebaseFirestore

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
                
                //check if user is a provider
                guard let userId = user?.user.uid else{
                    self.errorM = "User not found"
                    self.showError = true
                    return
                }
                
                //retreving user info through user id
                let db = Firestore.firestore()
                db.collection("users").document(userId).getDocument {snapshot, error in
                    
                    if let error = error {
                        self.errorM = "Error retreiving user data: \(error.localizedDescription)"
                        self.showError = true
                        return
                    }
                    
                    guard let data = snapshot?.data() else {
                        self.errorM = "User data not found"
                        self.showError = true
                        return
                    }
                    
                    //debug
                    print("isProvider: \(self.isProvider)")
                    
                    //check providerID if user is provider
                    /*if self.isProvider {
                        guard let storedProviderID = data["providerID"] as? String else{
                            self.errorM = "No provider ID found"
                            self.showError = true
                            return
                        }
                        
                        //compare input with provider ID in firestore
                        if storedProviderID != self.providerID {
                            self.errorM = "Provider ID does not match"
                            self.showError = true
                            return
                        }
                    }*/
                    
                    //determine is user is provider by checking if providerID exists
                    if let storedProviderID = data["providerID"] as? String {
                        //compare stored provider id and input
                        if storedProviderID != self.providerID {
                            self.errorM = "Provider ID does not match"
                            self.showError = true
                            return
                        }
                        //save roles
                        UserDefaults.standard.set(true, forKey: "userRole")
                    } else {
                        //no provider id - treat as patient user
                        UserDefaults.standard.set(false, forKey:"userRole")
                    }
                    
                    //save role to userDefaults
                    //UserDefaults.standard.set(self.isProvider, forKey: "userRole")
                    //triger navigation
                    //self.isLoggedIn = true
                    
                    onSuccess() //triggers navigation
                }
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
            //ensure it's a valid entry
            guard providerID.count == 10 && providerID.allSatisfy({$0.isNumber}) else {
                errorM = "Enter a valid 10-digit NPI ID"
                return false
            }

        }
        return true
    }
}
