//
// ModifyMedicationViewModel.swift
// PopAPill
//
// created by bartelsri 3/26/25
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class ModifyMedicationViewModel: ObservableObject{
    @Published var medName = ""
    @Published var dosage = ""
    @Published var unit = ""
    @Published var frequency = ""

    @Published var errorM = ""         //error message
    @Published var showError = false   //flag to show error message

    // initializer
    init() {}

    // save medication to firestore
    func saveMedication(){
        guard let userID = Auth.auth().currentUser?.uid else{
            return
        }
        guard validateInputs() else{
            return
        }

        let db = Firestore.firestore()

        let data: [String: Any] = [
            "name": medName,
            "dosage": Int(dosage) ?? 0,   //convert to int
            "unit": unit,
            "frequency": Int(frequency) ?? 0 //convert to int
        ]

        db.collection("users")
        .document(userID)
        .collection("medications")
        .document(medName)
        .setData(data){[weak self] error in
            guard error == nil else{
                print("Error saving medication: \(error!.localizedDescription)")
                return
            }

            // update UI on main thread after successful save
            DispatchQueue.main.async{
                self?.showError = false
            }
        }

    }

    private func validateInputs() -> Bool{
        if medName.isEmpty || dosage.isEmpty || unit.isEmpty || frequency.isEmpty{
            errorM = "Please fill in all fields."
            showError = true
            return false
        }

        if Int(dosage) == nil || Int(frequency == nil){
            errorM = "Dosage and frequency must be numbers."
            showError = true
            return false
        }
        return true
    }


}