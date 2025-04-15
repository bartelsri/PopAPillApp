//
//  RegisterViewViewModel.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class RegisterViewModel: ObservableObject {
    
    
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var errorM = ""
    
    
    init(){}

    
    func register(){
        guard validate() else {
            return
        }
        
       //create the user
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result , error in
            if let error = error {
                
                DispatchQueue.main.async {
                    self?.errorM = error.localizedDescription
                }
                return
            }
            guard let userId = result?.user.uid else {
                self?.errorM = "Could not create user"
                return
            }
            self?.insertUser(id: userId )
            
        }
        
        
    }
    //takes the user id
    private func insertUser(id: String ){
        let newUser =  User(id: id,
                            name: name,
                            email: email,
                            joined: Date().timeIntervalSince1970)
        //into database
        let db = Firestore.firestore()
        
        db.collection("users").document(id).setData(newUser.asDictionary() )
    }
    
    private func validate () -> Bool {
        errorM = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            
            errorM = "Please fill all fields"
            return false
        }
        guard email.contains( "@" ) && email.contains(".") else {
            errorM = "Enter a valid email address"
            return false
        }
        guard password.count >= 6 else {
            errorM = "Password must be at least 6 characters long"
            return false
        }
        return true
    }
    
        
    
}
