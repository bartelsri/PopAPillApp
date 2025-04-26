import Foundation
//
//  Patient.swift
//  PopAPill
//
//  Created by bartelsri on 4/21/25
//

struct Patient: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
    var medications: [Medication]

    // initializer for Firestore data
    init?(from data: [String: Any], id: String) {
            guard let name = data["name"] as? String,
                  let email = data["email"] as? String,
                  let joined = data["joined"] as? TimeInterval else {
                return nil
            }

            self.id = id
            self.name = name
            self.email = email
            self.joined = joined
        
        // Ensure medications is an array of Medication, or default to an empty array if not present
                if let medicationsData = data["medications"] as? [[String: Any]] {
                    self.medications = medicationsData.compactMap { Medication(from: $0, id: $0["id"] as? String)}
                } else {
                    self.medications = [] // Default to empty array if no medications exist
                }
            }
        }

