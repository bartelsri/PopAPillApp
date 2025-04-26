//
// Medication.swift
// PopAPill
//
// created by bartelsri 3/26/25

import Foundation

struct Medication: Identifiable, Codable {
   var id: String?  // firestore doc id
   let name: String
   let dosage: Int
   let unit: String
   let frequency: Int

    func toDict() -> [String: Any]{
        return[
            "name": name,
            "dosage": dosage,
            "unit": unit,
            "frequency": frequency
        ]
    }

    // initialize from firestore doc
    init(from data: [String: Any], id: String?){
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.dosage = data["dosage"] as? Int ?? 0
        self.unit = data["unit"] as? String ?? ""
        self.frequency = data["frequency"] as? Int ?? 0
    }
}