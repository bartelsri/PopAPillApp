//
//  ProfileViewViewModel.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject{
    @Published var user: User? = nil  //current user data
    @Published var errorM: String = ""
    @Published var isLoading: Bool = false
    @Published var isUpdating: Bool = false

    init(){
        fetchUserProfile()
    }

    func fetchUserProfile(){
            guard let userId = Auth.auth().currentUser?.uid else {
                errorM = "User not logged in."
                return
            }

            isLoading = true

            let db = Firestore.firestore()

            db.collection("users").document(userId).getDocument{ [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    DispatchQueue.main.async{
                        self?.errorM = "Failed to fetch user profile"
                        self?.isLoading = false
                    }
                    return
                }
                DispatchQueue.main.async {
                    self?.user = User (
                        id: data["id"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        joined: data["joined"] as? TimeInterval ?? 0
                    )
                    self?.isLoading = false
                }
            }
    }

    func updateProfile(name: String, email: String){
        //ensure user logged in
        guard let userId = Auth.auth().currentUser?.uid else{
            errorM = "User not logged in."
            return
        }

        //ensure name/email not empty
        guard !name.isEmpty, !email.isEmpty else{
            errorM = "Fill in all fields."
            return
        }

        isUpdating = true

        // new user object with updated data
        let updatedUser = User(id: userId, name: name, email: email, joined: Date().timeIntervalSince1970)

        let db = Firestore.firestore()

        // update firestore document with new data
        db.collection("users").document(userId).setData(updatedUser.asDictionary())
        {
            [weak self] error in DispatchQueue.main.async{
                self?.isUpdating = false
            }

            if let error = error{
                DispatchQueue.main.async{
                    self?.errorM = "Failed to update profile: \(error.localizedDescription)"
                }
            }

            else{
                self?.fetchUserProfile()
            }
        }
    }


   //logout of account
   func logOut(){
           do {
               try Auth.auth().signOut()

           } catch {
               print(error)
           }


       }

}