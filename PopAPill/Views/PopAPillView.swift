//
//  PopAPillView.swift
//  PopAPill
//
//  Created by jossyris on 3/4/25.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var title: String
    let image: String
    let imageColor: Color
    let destination: AnyView
    
}

struct PopAPillView: View {
    
    //three items that belong to the user
    let items = [
        Item(title: "Receive Alerts", image: "bell.and.waves.left.and.right.fill", imageColor: .white, destination: AnyView(ReceiveAlertsView())),
        Item(title: "Confirm Medication", image: "questionmark.text.page.fill", imageColor: .white, destination: AnyView(ConfirmMedView())),
        Item(title: "Medication History", image: "heart.text.clipboard.fill", imageColor: .white, destination:AnyView(MedHistoryView()))
        
    ]
    
    
    let spacing: CGFloat = 10
    @State private var numberOfRows = 1
    var body: some View {
        
        NavigationView {
            
            
            
            let colums = Array (
                repeating: GridItem(.flexible(), spacing: spacing),
                count: numberOfRows)
            
            
            
            VStack{
                ZStack{

                
                //header
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color(red: 1.0, green: 0.81, blue: 0.86))
                    .shadow(color: Color.black.opacity(0.17), radius: 10,y: 5)
                
                    .frame(width: UIScreen.main.bounds.width * 3, height: 600)
                
                    .offset(y:-100)
                    
                    
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
                LazyVGrid(columns: colums, spacing: spacing){
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
    }
}


struct ItemView: View {
    let item: Item
    
    var body: some View {
      
            
            
            VStack(spacing:5) {
                //image for each of the items in the list 
                Image(systemName: item.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(item.imageColor)
                    .frame(width:50)
                
                //text for each of the items in the list
                Text(item.title)
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
                
                
                
            }
            .frame(width: 360, height:140)
            .background(Color(red: 1.0, green: 0.81, blue: 0.86))
            .clipShape(RoundedRectangle(cornerRadius:20))
            .shadow(color: Color.black.opacity(0.17), radius: 10,y: 5)
        
    }
}
struct PopAPillView_Previews: PreviewProvider {
    static var previews: some View {
        PopAPillView()
    }
}
