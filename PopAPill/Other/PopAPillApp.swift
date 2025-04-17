//
//  PopAPillApp.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//
import FirebaseCore
import SwiftUI
import UserNotifications

@main
struct PopAPillApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @StateObject private var viewModel = MedReportViewModel()
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
            
        }
        .environmentObject(viewModel)
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    //when app is finished launching
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Request notification permission from the user
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {granted, error in
            //Check if there were any errors while requesting
            if let error = error {
                print("Error requestion notification permission: \(error)")
           //Either granted or denied
            } else if granted {
                print("Notifications granted")
            } else {
                print("Notifications not granted")
            }
        }
        
    
        
        //Observer to reset the badge when the app is active
        NotificationCenter.default.addObserver(self, selector: #selector(resetBadge), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        //Set the delegate to self so we can manage it
        UNUserNotificationCenter.current().delegate = self
        
        return true

    }
    
    //Allows notifications to be shown, even in foreground and within app
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping ( UNNotificationPresentationOptions) -> Void ) {
        
        // Shows the notification with a banner, sound, and badge
        completionHandler([.banner, .sound, .badge])
    }
    
    // Resets the app icon badge number to 0
    @objc func resetBadge() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
}
