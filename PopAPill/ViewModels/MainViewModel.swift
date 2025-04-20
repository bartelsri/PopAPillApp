//
//  MainViewViewModel.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//

import Foundation
import FirebaseAuth

//ViewModel to manage Firebase Authentication state
class MainViewModel: ObservableObject {
    // Keeps track of the current user ID
    @Published var currID: String = ""
    //Firebase Auth state listener handler
    private var handler: AuthStateDidChangeListenerHandle?
    //handling roles
    var isProvider: Bool {
        UserDefaults.standard.bool(forKey: "userRole")
    }

    
    init() {
        // Adds listener to observe authentication state changes
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                // Updates ID when user is logs in or out
                self?.currID = user?.uid ?? ""
            }
            
        }
    }
    
    // Checks if user is currently signed in 
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
        
    }
    
}
