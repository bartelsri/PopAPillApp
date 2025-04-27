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
    @ObservedObject var viewModel: PatientProfileViewModel
    var patient: Patient
    var patientId: String

    
    var body: some View {
        VStack {
            //header
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(Color(red: 1.0, green: 0.81, blue: 0.86))
                .shadow(color: Color.black.opacity(0.17), radius: 10,y: 5)
            
                .frame(width: UIScreen.main.bounds.width * 3, height: 300)
            
                .offset(y:-280)
            Text("Patient Profile")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
            //.padding(30)
                .offset(y:-400)
            
            //Display patient info
            /*Text("Name: \(patient.name)")
             .font(.title2)
             .bold()
             //.padding()
             .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
             .offset(x:-90, y:-275)
             
             Text("Contact: \(patient.email)")
             .font(.body)
             //.padding()
             .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
             .offset(x: -60, y:-250)*/
        } //end of first vstack
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
        
        //.padding()
        
        //medication list section
        VStack(alignment: .leading, spacing: 10){
            Text("Medications:")
                .font(.title2)
                .bold()
                .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
                .offset(x: -100, y:-225)
            
            if viewModel.medications.isEmpty {
                Text("No medications listed.")
                    .foregroundColor(.gray)
            } else {
                Text("Medications:")
                    .font(.headline)
                    .padding(20)
                
                ForEach(viewModel.medications) {medication in
                    Text("\(medication.name) - \(medication.dosage) \(medication.unit) \(medication.frequency) times per day")
                }
            }
        } //end of body
    } //end of struct
    
    
    /*//Display medication list
     Text("Medication(s):")
     ForEach(patient.medications) { medication in
     Text("\(medication.name) - \(medication.dosage) \(medication.dosageUnit) \(medication.frequency) times per day")
     }*/
}

