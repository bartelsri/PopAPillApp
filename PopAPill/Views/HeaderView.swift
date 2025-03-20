//
//  HeaderView.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//
import SwiftUI
struct HeaderView: View {
    let title: String
    let background: Color

    let image: Image?
    
    var body: some View {
        
     
                
                
                ZStack {
                    //rounded rectangle only header
                    RoundedRectangle(cornerRadius: 35)
                        .foregroundColor(Color(red: 1.0, green: 0.71, blue: 0.76))
                        .frame(width: 300, height: 70)
                    
                    HStack{
                        //Header text
                        Text(title)
                            .fontDesign(.rounded)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                            .foregroundColor(
                                Color(red: 1.0, green: 0.91, blue: 0.96))
                        
                        //Header icon
                        if let image = image {
                            image
                                .resizable()
                                .frame(width:30, height:30)
                                .bold(true)
                                .rotationEffect(.degrees(-90))
                                .offset(x: 10)
                                .foregroundColor(
                                    Color(red: 1.0, green: 0.91, blue: 0.96))
                        }
                    }
                }
                .frame(width: 300, height: 70)
                
                //end of header, title, and image zstack
                
                
            }
            //end of vstack
            
        
    
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        //properites of the header, includes
        //title, background color, and image 
        HeaderView(title: "Pop A Pill",
                   background: Color(red: 1.0, green: 0.81, blue: 0.86),
                   image: Image(systemName: "pill"))
    }
}
