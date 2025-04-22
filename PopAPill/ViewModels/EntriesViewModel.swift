//
//  EntriesViewModel.swift
//  PopAPill
//
//  Created by jossyris on 4/16/25.
//

import Foundation
import FirebaseFirestore

struct EntriesViewModel: Identifiable, Codable {
  
    
    var id = UUID()
    let name: String
    let dosage: Int
    let confirmation: String
    let sideEffects: String
    let date: Date
    let time: Date

    //converting from firestore format to swift
    static func fromDictionary(dict: [String: Any]) -> EntriesViewModel? {
        guard let idString = dict["id"] as? String,
        let id = UUID(uuidString: idString),
        let name = dict["name"] as? String,
        let dosage = dict["dosage"] as? Int,
        let confirmation = dict["confirmation"] as? String,
        let sideEffects = dict["sideEffects"] as? String,
        let dateTimestamp = dict["date"] as? Timestamp,
        let timeTimestamp = dict["time"] as? Timestamp else{
            print("Error parsing dictionary to EntriesViewModel")
            return nil
        }

        let dateValue = dateTimestamp.dateValue()
        let timeValue = timeTimestamp.dateValue()

        return EntriesViewModel(id: id, name: name, dosage: dosage, confirmation: confirmation, sideEffects: sideEffects, date: dateValue, time: timeValue)
    }

    //converting Swift variables to firestore format
    func toDictionary() -> [String: Any]{
        return[
            "id": id.uuidString,
            "name": name,
            "dosage": dosage,
            "confirmation": confirmation,
            "sideEffects": sideEffects,
            "date": Timestamp(date: date),
            "time": Timestamp(date: time)
        ]
    }
}
