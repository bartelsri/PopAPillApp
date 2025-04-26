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
    //
    @Published var isProvider = false //checks whether provider or user
    @Published var providerID = ""
    //
    @Published var registrationComplete = false
    
    
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
                    //
                    //try? Auth.auth().signOut()
                    //self?.registrationComplete = true
                }
                return
            }
            guard let userId = result?.user.uid else {
                self?.errorM = "Could not create user"
                return
            }
            self?.insertUser(id: userId)
            
        }
        
        
    }
    
    //takes the user id
    private func insertUser(id: String ){
       //database
        let db = Firestore.firestore()
        
        let userData: [String: Any]
        //create user for provider
        if isProvider == true {
            let newUser = ProviderUser(id : id,
                               name: name,
                               email: email,
                               providerID: providerID,
                               joined: Date().timeIntervalSince1970)
            userData = newUser.asDictionary()
        }
        
        //create user for patient
        else {
            let newUser =  User(id: id,
                                name: name,
                                email: email,
                                joined: Date().timeIntervalSince1970)
            userData = newUser.asDictionary()
        }
            //write to firestone with completion handler
            db.collection("users").document(id).setData(userData){ error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorM = "Failed to save user: \(error.localizedDescription)"
                    }
                    return
                }
                do {
                    try Auth.auth().signOut()
                } catch {
                    print("Error signing out: \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    self.registrationComplete = true
            }
        }
        
        //sign out after registration (redirected back to login page)
       /* try? Auth.auth().signOut()
        //trigger navigation but to login screen
        DispatchQueue.main.async {
            self.registrationComplete = true
        }*/
        
        //into database
        //let db = Firestore.firestore()
        
        //db.collection("users").document(id).setData(newUser.asDictionary() )
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
        
        //validating hcp role
        if isProvider == true {
            
            guard !providerID.trimmingCharacters(in: .whitespaces).isEmpty else {
                errorM = "Please fill all fields"
                return false
            }
            guard providerID.count == 10 && providerID.allSatisfy({$0.isNumber}) else {
                errorM = "Enter a valid 10-digit NPI ID"
                return false
            }
        }
        return true
    }
    
}
