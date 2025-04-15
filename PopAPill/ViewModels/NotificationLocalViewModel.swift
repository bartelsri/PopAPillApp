//
//  NotificationLocalViewModel.swift
//  PopAPill
//
//  Created by jossyris on 4/14/25.
//

import Foundation
import UserNotifications

///View model for handling local notifications
public class NotificationLocalViewModel: ObservableObject {
    @Published var filteredNotifications: [UNNotificationRequest] = []

    
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
    func getPendingNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let filteredRequests = requests.filter { request in
                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                
                
                return trigger.nextTriggerDate() ?? Date() > Date()
            }
            return true
            
            }
                
            
                self.filteredNotifications = filteredRequests
            
         }
     }
    func removePendingNotifications(with identifer: String){
      UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifer])
         
         if let index = self.filteredNotifications.firstIndex(where: { $0.identifier == identifer}) {
             self.filteredNotifications.remove(at: index)
         }
             
         
     }
    // Notification trigger that gets converted into a string
       func formateDate(from trigger: UNNotificationTrigger?) -> String {
           // Access date components for scheduling

           guard let trigger = trigger as? UNCalendarNotificationTrigger,
                 let date = trigger.nextTriggerDate()else {

               // No next trigger date
               return "N/A"
           }
          // let date = trigger.nextTriggerDate() ?? Date()
           // Built in class to convert Date objects to strings
           let dateFormatter = DateFormatter()
           // Build of the date
           dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
           // Return the date in string form
           return dateFormatter.string(from: date)
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
