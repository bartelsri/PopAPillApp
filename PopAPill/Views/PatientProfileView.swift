//
//  PatientProfileView.swift
//  PopAPill
//
//  Created by Amy Orellana-A. on 4/10/25.
//
//patient profile view on HCP's end - what they see after patient is selected in PatientListView
//  option to modify med (leads to ModifyMedView) next to medicine info

import Foundation
import SwiftUI

//profile page structure
struct PatientProfileView: View {
    @StateObject var viewModel: PatientProfileViewModel
    var patient: Patient
    var patientId: String

    //initialize viewModel inside view using patientId
    init(patient: Patient, patientId: String) {
        self.patient = patient
        self.patientId = patientId
        self._viewModel = StateObject(wrappedValue: PatientProfileViewModel(patientId: patientId))
    }

    var body: some View{
        ScrollView{
            VStack{
                PatientProfileHeaderView()
                PatientInfoView(patient: patient)
                MedicationListView(viewModel: viewModel, patientId: patientId)
            }
            .padding(.top)
        }
    }
}

//header struct
struct PatientProfileHeaderView: View{
    var body: some View {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(red: 1.0, green: 0.81, blue: 0.86))
                    .shadow(color: Color.black.opacity(0.17), radius: 10,y: 5)

                    .frame(width: UIScreen.main.bounds.width * 3, height: 300)

                    .offset(y:-280)

                Text("Patient Profile")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
                    .offset(y:-400)
        }
    }
}

//patient info
struct PatientInfoView: View {
    var patient: Patient

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Name: \(patient.name)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))

            Text("Contact: \(patient.email)")
                .font(.title2)
                .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
        } //end of patient vstack
        .offset(x:-40, y:-285)
    }
}

//medication list section
struct MedicationListView: View{
    @ObservedObject var viewModel: PatientProfileViewModel
    var patientId: String

    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            Text("Medications:")
                .font(.title2)
                .bold()
                .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
                .offset(x: -100, y:-225)

            //if no meds listed
            if viewModel.medications.isEmpty {
                Text("No medications listed.")
                    .foregroundColor(.gray)
            } else {   //Display medication list
                Text("Medications:")
                    .font(.headline)
                    .padding(20)

                //for each med object in view model for the patinet
                ForEach(viewModel.medications) { medication in
                    HStack{
                        Text("\(medication.name) - \(medication.dosage) \(medication.dosageUnit) \(medication.frequency) times per day")
                            .font(.body)
                            .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))

                            // move button down
                            Spacer()

                            // button to navigate to modify meds
                            NavigationLink(destination: ModifyMedView(medication: medication, patientId: patientId)){
                                Text("Modify")
                                    .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
                            }
                    } //end HStack
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)

                } //end ForEach (meds)

            } //end else
        } // end VStack (medication list)
        .padding(.horizontal)
    } //end of body for med
} //end of struct

