//
//  MedHistoryViewModel.swift
//  PopAPill
//
//  Created by jossyris on 4/16/25.
//

import Foundation

class MedReportViewModel: ObservableObject {
    @Published var entries: [EntriesViewModel] = []
    
    
    func addEntry(_ entry: EntriesViewModel) {
        entries.append(entry)
    }
}
