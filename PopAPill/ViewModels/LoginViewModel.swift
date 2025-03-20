//
//  LoginViewViewModel.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//
import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorM = ""
    
    init(){
        
    }
    
    func login()  {
        guard validate() else {
            return
        }
        // login user
        Auth.auth().signIn(withEmail: email, password: password)
            
        }
    
    
     func validate() -> Bool {
        errorM = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorM = "Fill in all fields"
            return false
        }
        // email contains @ and .
        guard email.contains("@") && email.contains(".") else {
            errorM = "Enter a valid email"
            return false
        }
        return true
    }
}
