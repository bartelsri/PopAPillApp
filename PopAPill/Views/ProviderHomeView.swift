//
//  ProviderHomeView.swift
//  PopAPill
//
//  Created by Amy Orellana-A. on 4/20/25.
//
// home page if logged in as health care provider with toggle
//  on login page
//based on PopAPillView

import SwiftUI

struct ProviderHomeView: View {
    @StateObject var viewModel = PopAPillViewModel()
    
    //three items that belong to the user
    let items = [
        Item(title: "Confirm Medication", image: "questionmark.text.page.fill", imageColor: .white, destination: AnyView(ConfirmMedView())),
        Item(title: "Medication History", image: "heart.text.clipboard.fill", imageColor: .white, destination:AnyView(MedHistoryView())),
                 /*Item(title: "Provider", image: "stethoscope", imageColor: .white, destination: AnyView(ProfileView())) //CORRECT DESTINATION (create HC provider page?) AND SPACING OF UI*/
    ]
    
    
    let spacing: CGFloat = 10
    @State private var numberOfRows = 1
    var body: some View {
        
        NavigationView {
            
            
            
            let colum = Array (
                repeating: GridItem(.flexible(), spacing: spacing),
                count: numberOfRows)
            
            
            
            VStack{
                ZStack{

                
                //header
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color(red: 1.0, green: 0.81, blue: 0.86))
                    .shadow(color: Color.black.opacity(0.17), radius: 10,y: 5)
                
                    .frame(width: UIScreen.main.bounds.width * 3, height: 600)
                
                    .offset(y:-130)
                    
                    
                    //takes user to settings
                    //maybe add this to the user profile instead of the home view
                    NavigationLink(destination: SettingsView()) {

                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 15)
                       
                    }
                    .offset(x: 152, y: -130)

                }
                
                //grid containing the items
                LazyVGrid(columns: colum, spacing: spacing){
                    ForEach(items) { item in
                        
                        NavigationLink(destination: item.destination) {
                            ItemView(item: item)
                        }
                        
                        
                    }
                    
                }
                .offset(y:-170)
                .background(Color.white)
                
            }
            
        }
        .environmentObject(ReceiveAlertsViewModel())

    }
}

struct ProviderHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProviderHomeView()
    }
}
