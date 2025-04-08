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

         //checking for valid unit

         //checking for valid frequency

         //checking when everything is valid

    }

}