//
//  User.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//

import Foundation


struct User: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
    
    init(id: String, name: String, email: String, joined: TimeInterval){
        self.id = id
        self.name = name
        self.email = email
        self.joined = joined
    }
    
    
}
