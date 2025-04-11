//
//  PatientProfileView.swift
//  PopAPill
//
//  Created by Amy Orellana-A. on 4/10/25.
//
//patient profile view on HCP's end - what they see after patient is selected in PatientListView
//  info: patient name, ID, DOB/age, symptoms?, medicine, dosage, how often they should be taking, are they on track?
//  option to modify med (leads to ModifyMedView) next to medicine info

import Foundation
import SwiftUI

//declaring Medication
struct PatientMedication: Identifiable { //is Medication already declared? where?
    var id = UUID()
    var name: String
    var dosage: Int
    var dosageUnit: String
    var frequency: Int //add "x per day" - then use this int to calculate when notifications should be sent
}

//adding more properties to Patient
struct ExtendedPatient {
        var id = UUID()
        var name: String
        //var contact: String
        var DOB: Date
        var email: String
        var medications: [PatientMedication]
}

//profile page structure
struct PatientProfileView: View {
    var patient: ExtendedPatient
    
    var body: some View {
        VStack {
            //Display patient info
            Text("Name: \(patient.name)")
                .font(.title)
                .padding()
                .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
            Text("DOB: \(patient.DOB)")
                .padding()
                .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
            Text("Contact: \(patient.email)")
                .padding()
                .foregroundColor(Color(red: 0.7, green: 0.4, blue: 0.6))
            
            //Display medication list
            Text("Medication(s):")
            ForEach(patient.medications) { medication in
                Text("\(medication.name) - \(medication.dosage) \(medication.dosageUnit) \(medication.frequency) times per day")
            }
        }
    }
}
