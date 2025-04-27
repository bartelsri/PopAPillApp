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
    var documentID: String?
    //converting Swift variables to firestore format
    func toDictionary() -> [String: Any]{
        return[
            "id": id.uuidString,
            "name": name,
            "dosage": dosage,
            "confirmation": confirmation,
            "sideEffects": sideEffects,
            "date": date,
            "time": time
        ]
    }

    //converting from firestore format to swift
    static func fromDictionary(_ dict: [String: Any], documentID:String) -> EntriesViewModel? {
        guard
        let name = dict["name"] as? String,
        let dosage = dict["dosage"] as? Int,
        let confirmation = dict["confirmation"] as? String,
        let sideEffects = dict["sideEffects"] as? String,
        let date = dict["date"] as? Timestamp,
        let time = dict["time"] as? Timestamp,
        let idString = dict["id"] as? String,
        let uuid = UUID(uuidString: idString)
        else{
            return nil
        }
        return EntriesViewModel(id: uuid, name: name, dosage: dosage, confirmation: confirmation, sideEffects: sideEffects, date: date.dateValue(), time: time.dateValue(), documentID: documentID)
    }
}
