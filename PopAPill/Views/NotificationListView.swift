//
//  NotificationList.swift
//  PopAPill
//
//  Created by jossyris on 4/14/25.
//

import SwiftUI

struct NotificationListView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var alertName: String = ""
    @State private var selectedTime: String = ""
    @State private var selectedDate: String = ""
    
    var body: some View {
        
        VStack {
            
            
            
            Button("close"){
                dismiss()
                
            }
            
        }
        .padding()
        
        
    }
}

struct NotificationList_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView()
    }
}
