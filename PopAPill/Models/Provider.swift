//
//  Provider.swift
//  PopAPill
//
//  Created by Amy Orellana-A. on 4/26/25.
//
import Foundation

struct Provider: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let email: String
    let providerID: String
    let joined: TimeInterval

    // initializer for Firestore data
    init?(from data: [String: Any], id: String) {
            guard let name = data["name"] as? String,
                  let email = data["email"] as? String,
                  let providerid = data["providerID"] as? String,
                  let joined = data["joined"] as? TimeInterval else {
                return nil
            }

            self.id = id
            self.name = name
            self.email = email
            self.providerID = providerid
            self.joined = joined
        }
}
