//
// ModifyMedView.swift
// PopAPill
//
// created by bartelsri 3/26/25
//View for provider to modify/add medications
/*
import SwiftUI

 struct ModifyMedView: View{

    @StateObject var viewModel = ModifyMedicationViewModel()
    @Binding var selectedPatient: Patient?

    @State private var medicationName = ""
    @State private var dosage: int = 0
    @State private var unit = ""
    @State private var frequency: int = 0

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
        }

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
                    Text("\(medication.dosage) \(medication.unit) \(medication.frequency) time(s) a day")
                }
                .onTapGesture{
                    viewModel.selectedMedication = medication
                    medicationName = medication.name
                    dosage = "\(medication.dosage ?? 0)"
                    unit = medication.unit
                    frequency = "\(medication.frequency ?? 0)"
                }

            }
        }

        // adding/updating medication
        VSTack{
            Text("Medication", text: $medicationName)
                .padding()

            Text("Dosage", text: $dosage)
                .padding()

            Text("Unit", text: $unit)

            Text("Frequency", text: $frequency)
                .padding()
        }
        //navigate to 'update medication'

        //select existing medication

        //update dosage

        //update unit

        //update frequency

        //add new medication

        //new medication dosage

        //new medication unit

        //new medication frequency



    }
    .onAppear{
        if let selectedPatient = selectedPatient{
            viewModel.loadMedications(for: selectedPatient.id)
        }
    }
}
*/