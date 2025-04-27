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
                    let data = doc.data()
                    let patient = Patient(from: data, id: doc.documentID)

                    if let patient = patient {
                        print("Loaded Patient: \(patient.name)")
                    }
                    else{
                        print("Failed to parse patient for doc ID: \(doc.documentID)")
                    }
                    return patient
                }
            }
        }
    }

    //initialize and load patients when view model is created
    init(){
       loadPatients()
    }

}

