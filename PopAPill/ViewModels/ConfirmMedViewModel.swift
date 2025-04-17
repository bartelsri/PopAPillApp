//
//  ConfirmMedViewModel.swift
//  PopAPill
//
//  Created by jossyris on 4/15/25.
//

import Foundation

class ConfirmMedViewModel: ObservableObject {

  
    @Published var medName = ""
     @Published var medDosage = ""
     @Published var medFrequency = ""
     @Published var medForm = ""
    @Published var medDate: Date = Date()
    @Published var medTime: Date = Date()
    @Published var medConfirmation = ""
    @Published var medTimeTaken = ""
    @Published var medSideEffects = ""
    
 
    
}
