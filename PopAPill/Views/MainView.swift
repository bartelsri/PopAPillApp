//
//  ContentView.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    
    var body: some View {
            //Shows from the login view view if signed in
        if viewModel.isSignedIn, !viewModel.currID.isEmpty {
            
            TabView{
                PopAPillView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
               
                
              /*  ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle") 
                    } */
            }
            
        } else {
            //not signed in, takes user back to login view 
            LoginView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
