//
//  MainViewViewModel.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//

import Foundation
import FirebaseAuth

class MainViewModel: ObservableObject {
    @Published var currID: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                
                
                self?.currID = user?.uid ?? ""
            }
            
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
        
    }
    
}
