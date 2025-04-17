//
//  NotificationList.swift
//  PopAPill
//
//  Created by jossyris on 4/14/25.
//

import SwiftUI
import UserNotifications

struct NotificationListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject  var viewModel = NotificationLocalViewModel()
    
    var body: some View {
        NavigationView {
            
            List{
                ForEach(viewModel.filteredNotifications, id: \.identifier) { notification in
                    VStack {
                        Text(notification.content.body)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary)
                        
                        
                        Text("Date: \(viewModel.formateDate(from: notification.trigger))")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary)
                        
                      /*  Button(action: {
                            viewModel.removePendingNotifications(with: notification.identifier)
                        }) {
                            Text("Remove")
                                .foregroundColor(.red)
                            
                        }*/
                    }
                    .padding(8)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
                    .listRowInsets(EdgeInsets())
                    
                }
                .onDelete(perform: delete)
            }
            .navigationBarTitle("Notification List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                        
                    }
                    
                }
            }
            .onAppear {
                
                viewModel.getPendingNotifications()
            }
            
        }
    }
        
    func delete(at offsets: IndexSet) {
            for index in offsets {
                let notification = viewModel.filteredNotifications[index]
                
                viewModel.removePendingNotifications(with: notification.identifier)
            }
        }
    
}

struct NotificationList_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView()
    }
}
