import Foundation
//
//  Patient.swift
//  PopAPill
//
//  Created by bartelsri on 4/21/25
//

struct Patient: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval

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
        }

}