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
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        VStack{
            //title
            Text("Receive Alerts")
                .bold()
                .font(.system(size:30))
            GroupBox{
                Button("Notification"){
                    Task{
                        let not = Not(indetifer: UUID().uuidString,
                                      title: "title",
                                      body: "body", TimeInterval: 5,
                                      repeats: false)
                        await alertView.schedule(not: not)
                    }
                }
            } label: {
                Label("Receive", systemImage: "bell")
            }
                    
                }
            }
            
          /*  Text("")
            
                .task{
                    do {
                        try await alertView.requestAuthorization()
                    } catch {
                        print("")
                    }
                }*/
        
        
            
        }
    }
    
}

struct ReceiveAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveAlertsView()
            .environmentObject(ReceiveAlertsViewModel())
    }
}

