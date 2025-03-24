//
//  ReceiveAlertsViewModel.swift
//  PopAPill
//
//  Created by jossyris on 3/24/25.
//

import Foundation
import NotificationCenter

class ReceiveAlertsViewModel: ObservableObject {
    let nCenter = UNUserNotificationCenter.current()
        
        
    
    
    func requestAuthorization() async throws {
        try await nCenter.requestAuthorization(options: [.alert, .badge, .sound])
        
    }
    
    
    
    func schedule(not: Not ) async{
        let content = UNMutableNotificationContent()
        content.title = not.title
        content.body = not.body
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: not.TimeInterval,
                                                        repeats: false)
        
        let request = UNNotificationRequest(identifier: not.indetifer, content: content, trigger: trigger)
        try? await nCenter.add(request)
    }
    
}

