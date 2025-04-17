//
//  ConfirmMedView.swift
//  PopAPill
//
//  Created by jossyris on 3/17/25.
//

import SwiftUI
struct ConfirmMedView: View {
    
    @State private var showTime: Bool = false
    @State private var showDate: Bool = false
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ConfirmMedViewModel()
    
    // For the Medication Report Entries
    @EnvironmentObject var reportHistory: MedReportViewModel
    var body: some View {
        
        Form{
           // Section(header: Text("Confirmation Report")){
                TextField("Medication Name", text: $viewModel.medName)
                TextField("Medication Dosage", text: $viewModel.medDosage)
                TextField("Medication Confirmation", text: $viewModel.medConfirmation)
           
                TextField("Side Effects", text: $viewModel.medSideEffects)
           
            
            Toggle("Time", isOn: $showTime)
                .toggleStyle(SwitchToggleStyle())
            if showTime {
                DatePicker("Select Time", selection: $viewModel.medTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(CompactDatePickerStyle())
            }
            Toggle("Date", isOn: $showDate)
            
                .toggleStyle(SwitchToggleStyle())
            if showDate {
                DatePicker("Select Date",selection: $viewModel.medDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
            }
            
        
        }
        
        PAPButton(title: "Confirm",
                  backgroundColor: .green) {
            let newEntry = EntriesViewModel(
                name: viewModel.medName,
                dosage: Int(viewModel.medDosage) ?? 0,
                confirmation: viewModel.medConfirmation,
                sideEffects: viewModel.medSideEffects,
                date: viewModel.medDate,
                time: viewModel.medTime
                    
            )
            
            reportHistory.addEntry(newEntry)
            
            dismiss()
            
        }
    
        .navigationBarTitle("Confirm Medication")

    }
}



struct ConfirmMedView_Previews: PreviewProvider {
    static var previews: some View {
               let example = MedReportViewModel()
               example.entries = [
                   EntriesViewModel(name: "",
                                    dosage: 0,
                                    confirmation: "",
                                    sideEffects: "",
                                    date: Date(),
                                    time: Date()
                                    ),
                   
               ]
               
               return ConfirmMedView()
                   .environmentObject(example)
              
       }
}
