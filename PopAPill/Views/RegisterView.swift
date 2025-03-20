//
//  RegisterView.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//

import Foundation
import SwiftUI


struct RegisterView: View {
    
    @StateObject var registerViewModel = RegisterViewModel()
    
    var body: some View {
         
            
            
            VStack {
                // Header view
                HeaderView(title: "Register",
                           background: Color(red: 1.0, green: 0.71, blue: 0.76),
                           image: nil)
                Spacer()
                
                ZStack{
                    
                    
                    
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(red: 1.0, green: 0.71, blue: 0.76))
                        .frame(width: 350, height: 300)
                        .offset(y:-150)
                    
                    Image(systemName: "pill.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color(red: 1.0, green: 0.71, blue: 0.76))
                        .background(Color(red: 1.0, green: 0.81, blue: 0.86))
                        .clipShape(Circle())
                    
                        .offset(y:-300)
                    
                    
                    VStack {
                        if !registerViewModel.errorM.isEmpty
                        {
                            Text(registerViewModel.errorM)
                                .foregroundColor(.red)
                        }
                        
                        TextField( "Full name", text: $registerViewModel.name)
                            .autocorrectionDisabled()
                        
                            .padding( )
                            .background(Color(.secondarySystemBackground))
                        
                            .frame(height:45)
                            .cornerRadius(8)
                            .offset(y:160)
                        
                        TextField( "Email Address", text: $registerViewModel.email)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .frame(height:45)
                            .cornerRadius(8)
                            .offset(y:170)
                        
                        
                        SecureField( "Password", text: $registerViewModel.password)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .frame(height:45)
                            .cornerRadius(8)
                            .offset(y:180)
                        
                        //login button
                        PAPButton(
                            title: "Create Account",
                            backgroundColor: .blue) {
                                
                                registerViewModel.register()
                                //attempt to login
                                
                                
                            }
                            .offset(y:180)
                    }
                    
                    //END OF VSTACK
                    .offset(y: -300)
                    .padding()
                    
                }
                //END OF VTSACK
                .padding()
                
            }
            .background(Color(red: 1.0, green: 0.81, blue: 0.86))
            
            
        }
    
}
        
struct RegisterView_Previews: PreviewProvider {
            static var previews: some View {
                RegisterView()
            }
        }
  
