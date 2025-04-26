//
// PatientListView.swift
// PopAPill
//
// created by bartelsri 3/26/25
//
//View of a list of patients and selecting one to view/modify their meds

import Foundation
import SwiftUI

struct PatientListView: View{
    //binding to hold selected patient
    @Binding var selectedPatient: Patient?
    //viewModel for fetching patients
    @ObservedObject private var viewModel = PatientListViewModel()

    var body: some View{
        NavigationView{
            VStack{
                //showing "Patient List" as header in  a mauve/purple color
                Text("Patient List")
                    .padding(40)
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))

                List(viewModel.patients) {patient in
                    HStack{
                        //showing the names of patients in white color
                        Text(patient.name)
                            .foregroundColor(.white)
                        Spacer()
                        //showing the Select button (to select the patient) with a mauve button and white text
                        Button("Select"){
                            selectedPatient = patient
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color(red: 0.7, green: 0.4, blue: 0.6))
                        .cornerRadius(8)
                    }
                    .padding()
                    .background(Color(red: 1.0, green: 0.7, blue: 0.8))
                    .cornerRadius(8)
                }

                //entire background of page is the signature Pop-A-Pill pink
                .background(Color(red: 1.0, green: 0.81, blue: 0.86))
                .ignoresSafeArea()
            }
            .onAppear{
                //load patients
                viewModel.loadPatients()
            }
        }
    }
}

struct PatientListView_Previews: PreviewProvider{
    static var previews: some View{
        PatientListView(selectedPatient: .constant(nil))
    }
}
