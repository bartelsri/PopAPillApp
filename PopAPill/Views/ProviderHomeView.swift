//
//  ProviderHomeView.swift
//  PopAPill
//
//  Created by Amy Orellana-A. on 4/20/25.
//
// home page if logged in as health care provider with toggle
//  on login page
//structure based on PopAPillView
//NOT DONE

import SwiftUI

struct ProviderHomeView: View {
    @StateObject var viewModel = PopAPillViewModel()
    @State private var selectedPatient: Patient? = nil //so i can use PatientListView as a destination

    //ItemView specifically for ProviderHomeView - based on ItemView from PopAPillView
    struct ProviderItemView: View {
        let item: ProviderItem

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
                .frame(width: 350, height:150)
                .background(Color(red: 1.0, green: 0.81, blue: 0.86))
                .clipShape(RoundedRectangle(cornerRadius:20))
                .shadow(color: Color.black.opacity(0.17), radius: 10,y: 5)

        }
    }
    
    //redefining item structure
    struct ProviderItem: Identifiable {
        let id = UUID()
        let title: String
        let image: String
        let imageColor: Color
    }

    
    //items that belong to the HCP
    let items = [
        ProviderItem(title: "Patient List", image: "text.page.fill", imageColor: .white)
        /*ProviderItem(title: "Non-Adhering Patients", image: "clock.fill", imageColor: .white)*/
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
                
                    .frame(width: UIScreen.main.bounds.width * 3, height: 200)
                
                    .offset(y:-280)
                    
                    Text("Provider Home Page")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .offset(y: -250)
                    
                    
                    //takes user to settings
                    //maybe add this to the user profile instead of the home view
                    NavigationLink(destination: SettingsView()) {

                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 15)
                       
                    }
                    .offset(x: 152, y: -300)

                }
                
                //grid containing the items
                LazyVGrid(columns: colum, spacing: spacing){
                    //destinations for the items
                    ForEach(items) { item in
                        NavigationLink(destination: {
                            if item.title == "Patient List" {
                                PatientListView(selectedPatient: $selectedPatient)
                            } else {
                                MedHistoryView()
                            }
                        }) {
                            ProviderItemView(item: item)
                        }
                    }
                }
                .offset(y:-250)
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
