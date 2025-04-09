//
// ModifyMedicationViewModel.swift
// PopAPill
//
// created by bartelsri 3/26/25
//

import Foundation

class ModifyMedicationViewModel: ObservableObject{
    //name of patient medication
    @Published var medName = ""
    //dosage for the medication
    @Published var dosage = ""
    //unit of the dosage
    @Published var unit = ""
    //how often the medication should be used
    @Published var frequency = ""

    @Published var errorM = ""         //error message
    @Published var showError = false   //flag to show error message

    func validate() -> Bool{
       // checking for empty fields
       if medName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || dosage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            unit.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || frequency.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
             errorM = "Please fill in all fields"
             showError = true
             return false
        }
       //checking for valid dosage
       guard let validDosage = Int(dosage), validDosage > 0 else{
            errorM = "Invalid dosage"
            showError = true
            return false
       }

       //checking for valid unit
       let validUnits = ["Pill", "Tablet", "Capsule", "mL"]
        if !validUnits.contains(unit){
            errorM = "Invalid unit"
            showError = true
            return false
        }

       //checking for valid frequency
       guard let validFreq = Int(frequency), validFreq > 0 else{
        errorM = "Invalid frequency"
        showError = true
        return false
       }

       //checking when everything is valid
       errorM = ""
       showError = false
       return true


    }

}