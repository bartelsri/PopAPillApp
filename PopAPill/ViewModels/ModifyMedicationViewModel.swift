//
// ModifyMedicationViewModel.swift
// PopAPill
//
// created by bartelsri 3/26/25
//ViewModel backend for when provider places inputs for medication
/*
import Foundation
import FirebaseFirestore

class ModifyMedicationViewModel: ObservableObject{
    //name of patient medication
    @Published var medName = ""
    //dosage for the medication
    @Published var dosage: Int? = nil
    //unit of the dosage
    @Published var unit = ""
    //how often the medication should be used
    @Published var frequency: Int? = nil

    @Published var errorM = ""         //error message
    @Published var showError = false   //flag to show error message

    @Published var medications: [Medication] = []
    @Published var selectedMedication: Medication?

    private var db = Firestore.firestore()

    func validate() -> Bool{
       // checking for empty fields input
       if medName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            unit.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
             errorM = "Please fill in all fields"
             showError = true
             return false
        }
       //checking for valid dosage input
       guard let validDosage = dosage, validDosage > 0 else{
            errorM = "Invalid dosage"
            showError = true
            return false
       }

       //checking for valid unit input
       let validUnits = ["Pill", "Tablet", "Capsule", "mL"]
        if !validUnits.contains(unit){
            errorM = "Invalid unit"
            showError = true
            return false
        }

       //checking for valid frequency input
       guard let validFreq = frequency, validFreq > 0 else{
        errorM = "Invalid frequency"
        showError = true
        return false
       }

       //checking when everything is a valid input
       errorM = ""
       showError = false
       return true

    }
 // load medications for a selected patient
    func loadMedications(for patientID: String) {
        db.collection("users")
            .document(patientID)
            .collection("medications")
            .getDocuments { snapshot, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorM = "Error loading medications: \(error.localizedDescription)"
                        self.showError = true
                    }
                    return
                }

                guard let documents = snapshot?.documents else {
                    DispatchQueue.main.async {
                        self.errorM = "No medications found."
                        self.showError = true
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.medications = documents.compactMap { doc in
                        Medication(from: doc.data(), id: doc.documentID)
                    }
                }
            }
    }

    // add new medication to Firestore
    func addMedication(for patientID: String) {

        if !validate() {
            return
        }

        // Create a new Medication
        let newMedication = Medication(from: [
            "name" : medName,
            "dosage" : dosage ?? 0,
            "unit" : unit,
            "frequency" : frequency ?? 0 ], id: nil)

        // Save to Firestore
        db.collection("users")
            .document(patientID)
            .collection("medications")
            .addDocument(data: newMedication.toDict()) { error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorM = "Error adding medication: \(error.localizedDescription)"
                        self.showError = true
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.loadMedications(for: patientID)
                    self.errorM = "Medication added successfully"
                    self.showError = false
                }
            }
    }

    // Update an existing medication
    func updateMedication(for patientID: String) {
        guard let selectedMedication = selectedMedication else {
            return
        }

        // Validate inputs before updating
        if !validate() {
            return
        }

        // Update medication with the new details
        let updatedMedication = Medication(from: [
            "name" : medName,
            "dosage" : dosage ?? 0,
            "unit" : unit,
            "frequency" : frequency ?? 0 ], id: selectedMedication.id)

        // Update the medication in Firestore
        db.collection("users")
            .document(patientID)
            .collection("medications")
            .document(selectedMedication.id ?? "") // unwrap id
            .setData(updatedMedication.toDict(), merge: true) { error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorM = "Error updating medication: \(error.localizedDescription)"
                        self.showError = true
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.errorM = "Medication updated successfully"
                    self.showError = false
                }
            }
    }

    // Delete a medication from Firestore
    func deleteMedication(for patientID: String) {
        guard let selectedMedication = selectedMedication else {
            return
        }

        // Delete medication from Firestore
        db.collection("users")
            .document(patientID)
            .collection("medications")
            .document(selectedMedication.id ?? "") //unwrap id
            .delete { error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorM = "Error deleting medication: \(error.localizedDescription)"
                        self.showError = true
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.errorM = "Medication deleted successfully"
                    self.showError = false
                }
            }
    }
}
*/
