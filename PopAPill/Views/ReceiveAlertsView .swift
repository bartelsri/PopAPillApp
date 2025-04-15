//
//  ReceiveAlertsView .swift
//  PopAPill
//
//  Created by jossyris on 3/17/25.
//

import Foundation
import SwiftUI


struct ReceiveAlertsView: View {
    @EnvironmentObject var alertView: ReceiveAlertsViewModel
    @State private var isAddingNewAlert = false
    @State private var showingNotificationList = false
    
    
    var body: some View {
        
        ZStack{
            Color(red:1.0, green: 0.81, blue: 0.86)
                .ignoresSafeArea()
            VStack {
                Text("Add Alert or View Notifications")
                    .font(.title)

                    .font(.headline)
                    .offset(y: -180)
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding()
                
                
                HStack{
                    Button(action: {
                        
                        isAddingNewAlert.toggle()
                    }) {
                        VStack(spacing: 2){
                            Image(systemName: "bell")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .offset(y:-90)

                            
                            Text("Add New Alert")
                               // .font(.headline)
                                
                            
                        }
                        .frame(width:150, height: 300)
                        .padding()
                        .background(.white)
                        .foregroundColor(Color.primary)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .frame(width: 190, height: 100)
                    }
                    .sheet(isPresented: $isAddingNewAlert) {
                        AddNewAlertView()
                        
                        
                    }
                    
                    Button(action: {
                        showingNotificationList.toggle()
                    }) {
                        VStack(spacing: 1){
                            Image(systemName: "list.bullet.below.rectangle")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .offset(y:-90)
                            
                            Text("Notification List")
                                .font(.headline)
                              
                             
                            
                        }
                        .frame(width:150, height: 300)
                        .padding()
                        .background(.white)
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .frame(width: 190)
                    }
                    .sheet(isPresented: $showingNotificationList){
                        NotificationListView()
                    }
                }
            }
        }
        
    }
}

struct ReceiveAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveAlertsView()
    }
}

