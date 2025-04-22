//
//  PatientListViewModel.swift
//  PopAPill
//
//  Created by bartelsri on 4/21/25.
//

import Foundation
import FirebaseFirestore

class PatientListViewModel: ObservableObject {

    // list of patients that the view will observe and display
    @Published var patients: [User] = []
    @Published var errorM: String?

    // load patient data from Firestore
    func loadPatients(){

        let db = Firestore.firestore()

        //load documents from "users" collection in firestore
        db.collection("users").getDocuments { snapshot, error in
            if let error = error{
               //handle error if there's a problem fetching data from firestore
                DispatchQueue.main.async{
                    self.errorM = ("Error loading patients: \(error.localizedDescription)")
                }
                return
            }


            //ensure documents are in the snapshot
            guard let documents = snapshot?.documents else{
                DispatchQueue.main.async{
                    self.errorM = "No patient data found."
                }
                return
            }

            // convert each firestore document into a patient model
            DispatchQueue.main.async{
                self.patients = documents.compactMap { doc in
                    guard let user = User(document: doc.data(), id: doc.documentID)
                    else{
                        return nil
                    }
                    return Patient(id: UUID(), name: user.name)
                }
            }
        }
    }

    //initialize and load patients when view model is created
    init(){
        loadPatients()
    }

}

// user model extension for initializing a user object from Firestore data
extension User{
    //initializes a user model from firestore document dictionary
    init?(document: [String: Any], id: String){
        // unwrap properties from firestore document
        guard let name = document["name"] as? String,
              let email = document["email"] as? String,
              let joined = document["joined"] as? TimeInterval
              else{
                    // return nil if any fields are missing
                    return nil
              }


        //assign unwrapped properties to user model
        self.id = id
        self.name = name
        self.email = email
        self.joined = joined
    }
}
