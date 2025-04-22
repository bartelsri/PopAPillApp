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
    @Published var patients: [Patient] = []
    @Published var errorM: String? = nil

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
                    // initialize User from firestore data
                    let data = doc.data()
                    if let id = doc.documentID,
                       let name = data["name"] as? String,
                       let email = data["email"] as? String,
                       let joined = data["joined"] as? TimeInterval{
                            let patient = Patient(id: id, name: name, email: email, joined: joined)
                            return patient
                       }

                       return nil

                }
            }
        }
    }

    //initialize and load patients when view model is created
    init(){
        loadPatients()
    }

}

