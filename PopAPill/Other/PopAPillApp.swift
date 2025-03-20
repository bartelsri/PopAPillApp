//
//  PopAPillApp.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//
import FirebaseCore
import SwiftUI

@main
struct PopAPillApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
