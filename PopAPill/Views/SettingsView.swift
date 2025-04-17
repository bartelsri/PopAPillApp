//
//  SettingsView.swift
//  PopAPill
//
//  Created by jossyris on 3/18/25.
//

import SwiftUI
import UserNotifications

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
                            //toggle for enabling notifications
                            Section(header: Text("Receive Alerts")){
                                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                                    .onChange(of: notificationsEnabled) { value in
                                        //when toggle is ON
                                        if value{
                                            //asking user for authorization to send notifs
                                            UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .sound, .badge]) {granted, error in
                                                DispatchQueue.main.async{
                                                //if an error occurred
                                                   if let error = error{
                                                    //message showing user their was an error requesting notifs
                                                    alertMessage = "Notification error: \(error.localizedDescription)"
                                                    showAlert = true
                                                    notificationsEnabled = false
                                                    return
                                                    }
                                                   //if user said yes to notifs
                                                   if granted{
                                                    //message showing the user that notifs are turned on
                                                    alertMessage = "Notifications successfully turned on"
                                                    showAlert = true

                                                    notificationsEnabled = true
                                                  }
                                                  //if user said no to notifs
                                                  else{
                                                    //message showing the user that notifs are turned off
                                                    alertMessage = "Notification authorization was denied. Please enable them in Settings"
                                                    showAlert = true
                                                    //reset toggle
                                                    notificationsEnabled = false
                                                  }
                                               }
                                            }
                                        }
                                    }
                              // if the notifications are disabled
                              if !notificationsEnabled{
                                //send user a message saying they can enable them in Settings
                                Text("Notifications are currently off. You can enable them in Settings")
                                    .font(.footnote)
                                    //mauve color for foreground
                                    .foregroundColor((Color(red: 0.7, green: 0.4, blue: 0.6)))
                                    .padding(.top)
                                    .padding(.bottom, 4)
                                //pop up sending user to notification settings
                                Button(action: {
                                    if let appSettings = URL(string: UIApplication.openSettingsURLString),
                                        UIApplication.shared.canOpenURL(appSettings){
                                            UIApplication.shared.open(appSettings)
                                    }
                                }) {
                                    //customizing message to mauve color
                                    Text("Open Notification Settings")
                                        .foregroundColor((Color(red: 1.0, green: 0.81, blue: 0.86)))
                                        .fontWeight(.semibold)
                                   }
                              }
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
            .onAppear {
                viewModel.fetchUser()
                //showing if toggle is enabled or disabled for notification settings
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    DispatchQueue.main.async{
                        notificationsEnabled = settings.authorizationStatus == .authorized
                    }
                }
                
            }
            //UI showing when the notifs are denied or there is an error
        
    }
}

struct SettingsView_Proivder: PreviewProvider {
    static var previews: some View {
        
        
        SettingsView(viewModel: PopAPillViewModel())
    }
}
