//
//  Buttonv.swift
//  PopAPill
//
//  Created by jossyris on 3/4/25.
//

import SwiftUI

struct PAPButton: View {
    
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            //action
            action()
        } label: {
            ZStack{
                //shape of the button 
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(backgroundColor)
                    .frame(height:35)
               
                //color for text and properities
                Text(title )
                    .foregroundColor(.white)
                    .bold()
                
                
            }
            
        }
        .padding()

    }
}

struct PAPButton_Previews: PreviewProvider{
    static var previews: some View {
        PAPButton(title: "Hello",
                  backgroundColor: .blue){
            
        }
    }
}
