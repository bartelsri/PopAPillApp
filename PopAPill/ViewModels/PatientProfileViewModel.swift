//
//  PatientProfileViewViewModel.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class PatientProfileViewModel: ObservableObject {
    @Published var medications: [Medication] = [] // Published array to store medications
    var patientId: String

    init(patientId: String) {
        self.patientId = patientId
        fetchPatientMedications()
    }
    

    // Fetch medications for the patient from Firestore
    func fetchPatientMedications() {
        let db = Firestore.firestore()
        
        db.collection("users").document(patientId).getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }
            
            guard let document = document, document.exists,
                  let data = document.data() else {
                print("Document does not exist")
                return
            }

            // Assuming medications are stored as an array in Firestore
            if let medicationsData = data["medications"] as? [[String: Any]] {
                self.medications = medicationsData.compactMap { Medication(from: $0, id: $0["id"] as? String) }
            } else {
                self.medications = [] // Set medications to an empty array if not available
            }
        }
    }
}
