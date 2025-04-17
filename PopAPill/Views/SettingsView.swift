//
//  SettingsView.swift
//  PopAPill
//
//  Created by jossyris on 3/18/25.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = PopAPillViewModel()
    
    var body: some View {
            
            
            VStack{
                if let user = viewModel.user{
                    
                    
                    VStack(alignment: .leading){
                        Form{
                            Section(header: Text("Personal Information")){
                                HStack {
                                    Text("Name: ")
                                    Text(user.name)
                                }
                                .listRowSeparator(.hidden)
                                HStack {
                                    Text("Email: ")
                                    Text(user.email)
                                }
                                .listRowSeparator(.hidden)
                                HStack{
                                    Text("Member Since: ")
                                        .listRowSeparator(.hidden)
                                    Text("\(Date(timeIntervalSince1970:user.joined).formatted(date: .abbreviated, time: .shortened))")
                                    }
                                
                                }
                            
                            Section(header: Text("Receive Alerts")){
                            }
                            
                            
                            
                            
                                Section(header: Text("Login")){
                                    Button("Log Out"){
                                        viewModel.logOut()
                                    }
                                    .tint(Color.red)
                                }
                            }
                            
                        }
                        
                        
                    }
                else {
                    Text("...loading...")
                       
                }
                
            }
            .onAppear {
                viewModel.fetchUser()
                
            }
    
        
    }
}

struct SettingsView_Proivder: PreviewProvider {
    static var previews: some View {
        
        
        SettingsView(viewModel: PopAPillViewModel())
    }
}
