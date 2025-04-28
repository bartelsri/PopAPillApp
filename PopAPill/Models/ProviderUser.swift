//
//  ProviderUser.swift
//  PopAPill
//
//  Created by Amy Orellana-A. on 4/26/25.
//

import Foundation


struct ProviderUser: Codable {
    let id: String
    let name: String
    let email: String
    let providerID: String
    let joined: TimeInterval
    
}
