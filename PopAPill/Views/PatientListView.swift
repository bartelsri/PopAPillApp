//
// PatientListView.swift
// PopAPill
//
// created by bartelsri 3/26/25
//
//View of a list of patients and selecting one to view/modify their meds

import SwiftUI

struct PatientListView: View{
    //binding to hold selected patient
    @Binding var selectedPatient: User?
    //viewModel for fetching patients
    @ObservedObject private var viewModel = PatientListViewModel()
    //list of patients (hard coded)    4/21 - commented this out so we can pull actual data
//    @State private var patients: [Patient] = [
//        Patient(name: "Jack Johnson"),
//        Patient(name: "Suzy Craw"),
//        Patient(name: "Anna Heather")
//    ]

    var body: some View{
        VStack{
            //showing "Patient List" as header in  a mauve/purple color
            Text("Patient List")
                .padding(30)
                .font(.largeTitle)
                .padding()
                .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
            List(viewModel.patients) {user in
                HStack{
                    //showing the names of patients in white color
                    Text(user.name)
                        .foregroundColor(.white)
                    Spacer()
                    //showing the Select button (to select the patient) with a mauve button and white text
                    Button("Select"){
                        selectedPatient = user
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color(red: 0.7, green: 0.4, blue: 0.6))
                    .cornerRadius(8)
                }
                .padding()
            }

        }
        .navigationTitle("Select Patient")
        //entire background of page is the signature Pop-A-Pill pink
        .background(Color(red: 1.0, green: 0.81, blue: 0.86))
        .ignoresSafeArea()
        .onAppear{
            //load patients
            viewModel.loadPatients()
        }
    }
}

struct PatientListView_Previews: PreviewProvider{
    static var previews: some View{
        PatientListView(selectedPatient: .constant(nil))
    }
}
