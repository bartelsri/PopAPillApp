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

    init(id: String, name: String, email: String, joined: TimeInterval) {
        self.id = id
        self.name = name
        self.email = email
        self.joined = joined
    }
}