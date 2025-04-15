//
//  AddNewAlertView.swift
//  PopAPill
//
//  Created by jossyris on 4/14/25.
//

import SwiftUI

struct AddNewAlertView: View {
    
    @State private var alertName: String = ""
    @State private var selectedTime = Date()
    @State private var selectedDate = Date()
    @State private var isNotification = false
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        ZStack {
            Color(red:1.0, green: 0.81, blue: 0.86)
                .ignoresSafeArea()
            
            VStack(spacing: 20){
                HStack {
                    
                    Text("Medication Alerts")
                        .font(.title)
                        .font(.headline)
                        .bold(true)
                        .font(.system(size: 50))
                    //    .offset(y:-100)
                    
                    
                    Image(systemName: "Pill")
                        .bold(true)
                        .font(.title)
                    
                }
                .offset(y:-100)
                
                
                ZStack{
                    
                    
                    // Card style for the alert
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 8)
                        .frame(width: 350,height: 500)
                        .padding(.horizontal)
                    
                    VStack{
                        
                        
                        Image(systemName: "bell.badge")
                        //.font(.title)
                            .font(.system(size: 50))
                            .offset(y:-10)
                        
                        Text("Create an Alert")
                            .bold()
                            .font(.system(size: 30))
                        
                        
                        // Sub-text for directions on creating an alert
                        Text("Create a new alert below by entering a name and selecting a date and time")
                            .font(.subheadline)
                            .padding()
                            .foregroundColor(Color(.systemGray))
                            .multilineTextAlignment(.center)
                        
                            .padding(.horizontal)
                        
                        
                        
                        TextField("Alert Name", text: $alertName)
                        
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        
                            .datePickerStyle(.automatic)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        DatePicker("Select Time", selection: $selectedTime, displayedComponents:
                                    
                                .hourAndMinute)
                        .datePickerStyle(.automatic)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        
                        
                        PAPButton(title: "Save", backgroundColor: .blue){
                            scheduleLocalNotification()
                            self.dismiss()
                            
                        }
                        
                        //padding for button:
                        .padding(.horizontal)
                    }
                    .padding(.horizontal,30)
                    
                }
            }
            .disabled(isNotification)
            
            
        }
    }
    
    
    
    
    private func scheduleLocalNotification() {
        let notificationsList = NotificationLocalViewModel()
        let date = DatesViewModel()
        date.title = alertName
        date.iD = UUID().uuidString
        
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedDate)
        
        let TomeComponent = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedTime)
        
        date.year = dateComponent.year!
        date.month = dateComponent.month!
        date.day = dateComponent.day!
        date.hour = TomeComponent.hour!
        date.minute = TomeComponent.minute!
        
        notificationsList.scheduleNotification(for: date)
        isNotification = true
       
        
    
        
    }
}

struct AddNewAlertView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAlertView()
    }
}
