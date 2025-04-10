//
// ModifyMedView.swift
// PopAPill
//
// created by bartelsri 3/26/25
//

import SwiftUI

/* struct ModifyMedView: View{

    var body : some View {

        //navigate to patient list and select to patient to modify medication for
        VStack{
            //navigate to patient list
            NavigationLink(destination: PatientListView(selectedPatient: $selectedPatient)){
                Text("Select Patient")
                .font(.headline)
                .padding()
            }
        }

        if let selectedPatient = selectedPatient{
            //show selected patient's current medications
            Text("Current Medications for \(selectedPatient.name)")
            .font(.title)
            .padding()

            //list medications
            List(medicationList){
                medication in HStack{
                    Text(medication.name)
                    Spacer()
                    Text("\(medication.dosage) \(medication.unit) \(medication.frequency) time(s) a day")
                }
                .onTapGesture{
                    selectedMedication = medication
                }

            }
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

} */
