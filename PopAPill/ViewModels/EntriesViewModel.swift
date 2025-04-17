//
//  EntriesViewModel.swift
//  PopAPill
//
//  Created by jossyris on 4/16/25.
//

import Foundation

struct EntriesViewModel: Identifiable, Codable {
  
    
    var id = UUID()
    let name: String
    let dosage: Int
    let confirmation: String
    let sideEffects: String
    let date: Date
    let time: Date
    
    
    
    
}
