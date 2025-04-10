//
// PatientListView.swift
// PopAPill
//
// created by bartelsri 3/26/25
//
//home page for healthcare providers?

import SwiftUI

struct Patient: Identifiable{
    //identifier for patient
    var id = UUID()
    //name of patient
    var name: String
}

struct PatientListView: View{
    @Binding var selectedPatient: Patient?
    //list of patients
    @State private var patients: [Patient] = [
        Patient(name: "Jack Johnson"),
        Patient(name: "Suzy Craw"),
        Patient(name: "Anna Heather")
    ]

    var body: some View{
        VStack{
            Text("Patient List")
                .padding(30)
                .font(.largeTitle)
                .padding()
                .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
            List(patients) {patient in 
                HStack{
                    Text(patient.name)
                        .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
                    Spacer()
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
            }

        }
        .navigationTitle("Select Patient")
        .background(Color(red: 1.0, green: 0.81, blue: 0.86))
        .ignoresSafeArea()
    }
}

struct PatientListView_Previews: PreviewProvider{
    static var previews: some View{
        PatientListView(selectedPatient: .constant(nil))
    }
}
