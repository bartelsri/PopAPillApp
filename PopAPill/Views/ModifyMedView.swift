//
// ModifyMedView.swift
// PopAPill
//
// created by bartelsri 3/26/25
//View for provider to modify/add medications

import ModifyMedicationViewModel
import SwiftUI

 struct ModifyMedView: View{

    @StateObject var viewModel = ModifyMedicationViewModel()
    @Binding var selectedPatient: Patient?

    @State private var medicationName = ""
    @State private var dosage: Int = 0
    @State private var unit = ""
    @State private var frequency: Int = 0

    @State private var showError = false

    var body : some View {

        //navigate to patient list and select to patient to modify medication for
        VStack{
            //navigate to patient list
            NavigationLink(destination: PatientListView(selectedPatient: $selectedPatient)){
                Text("Select Patient")
                .font(.headline)
                .padding()
                .background(Color(red: 0.7, green: 0.4, blue: 0.6))
                .cornerRadius(8)
            }

            //show current meds
            if let selectedPatient = selectedPatient{
                //show selected patient's current medications
                Text("Current Medications for \(selectedPatient.name)")
                .font(.title2)
                .padding()

                //list medications
                List(viewModel.medications){
                    medication in HStack{
                        Text(medication.name)
                        Spacer()
                        Text("\(medication.dosage ?? 0) \(medication.unit) \(medication.frequency ?? 0) time(s) a day")
                    }
                    .onTapGesture{
                        viewModel.selectedMedication = medication
                        medicationName = medication.name
                        dosage = medication.dosage ?? 0
                        unit = medication.unit
                        frequency = medication.frequency ?? 0
                    }

                }


                // adding/updating medication
                VStack{
                    TextField("Medication", text: $medicationName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Dosage", value: $dosage, formatter: NumberFormatter())
                        .padding()
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Unit", text: $unit)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Frequency", value: $frequency, formatter: NumberFormatter())
                        .padding()
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    if viewModel.showError{
                        Text(viewModel.errorM)
                            .foregroundColor(.red)
                            .padding()
                    }

                    //add / update meds button
                    Button(action: {
                        viewModel.medName = medicationName
                        viewModel.dosage = dosage
                        viewModel.unit = unit
                        viewModel.frequency = frequency

                        if viewModel.selectedMedication == nil{
                            // add new
                            viewModel.addMedication(for: selectedPatient.id)
                        }
                        else{
                            // update selected
                            viewModel.updateMedication(for: selectedPatient.id)
                        }
                    })
                        {
                        Text(viewModel.selectedMedication == nil ? "Add Medication" : "Update Medication")
                            .font(.headline)
                            .padding()
                            .background(Color(red: 0.7, green: 0.4, blue: 0.6))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                .padding()
            }
        }

        .onAppear{
            if let selectedPatient = selectedPatient{
                viewModel.loadMedications(for: selectedPatient.id)
            }
        }
    }
}
