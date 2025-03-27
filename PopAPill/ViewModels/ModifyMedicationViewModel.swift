//
// ModifyMedicationViewModel.swift
// PopAPill
//
// created by bartelsri 3/26/25
//

import Foundation

class ModifyMedicationViewModel: ObservableObject{
    @Published var medName = ""
    @Published var dosage = ""
    @Published var unit = ""
    @Published var frequency = ""

    @Published var errorM = ""         //error message
    @Published var showError = false   //flag to show error message





}