//
//  NotificationLocalViewModel.swift
//  PopAPill
//
//  Created by jossyris on 4/14/25.
//

import Foundation
import UserNotifications

///View model for handling local notifications
public class NotificationLocalViewModel {
    
        // Request notification authorization and schedules the notification when
        // granted
        private func requestAuthorization(_ request: UNNotificationRequest) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted {
                    self.schedule(request)
                } else {
                    print("Permission not granted ")
                }
                
            }
        }
        
        // Schedules the local notification with the system
        private func schedule(_ request: UNNotificationRequest) {
            UNUserNotificationCenter.current().add(request){ error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled")
                }
                
            }
        }
      
    
    // Function to schedule a notification for a given date
    func scheduleNotification(for date: DatesViewModel){
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "Schedule Alert"
        notificationContent.body = date.title
        notificationContent.sound = UNNotificationSound.default
        notificationContent.badge = 1
        
        // Extract the date elements for the given date
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date.date)
        // Creating a trigger for the notification
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        // Create the notification request
        let request = UNNotificationRequest(identifier: date.iD, content: notificationContent, trigger: trigger)
        
        // Checks for authorization status 
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    self.schedule(request)
                }else {
                    self.requestAuthorization(request)
                }
            }
        }
    }
}
