//
//  MedHistoryView.swift
//  PopAPill
//
//  Created by jossyris on 3/17/25.
//  Views patient confirmation report

import SwiftUI

struct MedHistoryView: View {
    @EnvironmentObject var medHistoryViewModel: MedReportViewModel
    
   

    
    
    var body: some View {
        List {
            ForEach(medHistoryViewModel.entries){ entry in
                
                VStack(alignment: .leading) {
                    
                    Text("Medication Name: \(entry.name)")
                    Text("Dosage: \(entry.dosage)")
                    Text("Taken? \(entry.confirmation)")
                  
                   
                    Text("Side effects: \(entry.sideEffects)")
                    Text("Time: \(entry.date, style: .time)")
                    Text("Date: \(entry.time, style: .date)")
                    
                    
                    
                }
                
                
            }
            
            .onDelete(perform: delete)

        }
        .navigationTitle("Medication Report")
    }
    
    func delete(at offsets: IndexSet) {
        medHistoryViewModel.entries.remove(atOffsets: offsets)
    }

}

struct MedHistoryView_Previews: PreviewProvider{
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
                   
                
            return MedHistoryView()
                .environmentObject(example)
                    
            }
       
    
}
