//
//  RegisterView.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//

import Foundation
import SwiftUI


struct RegisterView: View {
    
    //for button destination
    //enum Destination: Hashable {
      //  case loginView
    //}

    @StateObject var registerViewModel = RegisterViewModel()
    //@State private var destination: Destination? = nil
    
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
                        .offset(y:-200)
                    
                    Image(systemName: "pill.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color(red: 1.0, green: 0.71, blue: 0.76))
                        .background(Color(red: 1.0, green: 0.81, blue: 0.86))
                        .clipShape(Circle())
                    
                        .offset(y:-350)
                    
                    
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
                            .offset(y:155)
                        
                        TextField( "Email Address", text: $registerViewModel.email)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .frame(height:45)
                            .cornerRadius(8)
                            .offset(y:165)
                        
                        
                        SecureField( "Password", text: $registerViewModel.password)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .frame(height:45)
                            .cornerRadius(8)
                            .offset(y:175)
                        
                        //toggle for provider account
                        Toggle(isOn: $registerViewModel.isProvider){
                            Text("Are you a provider?")
                                .font(.headline)
                                //.offset(y:300)
                                //.padding()
                        }
                        .offset(y:255)
                        //.padding()
                        //text field for provider ID if it is a provider
                        if registerViewModel.isProvider{
                            TextField("Provider ID", text: $registerViewModel.providerID)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .frame(height:45)
                                .cornerRadius(8)
                                .offset(y:145)
                        }
                        
                        
                        //login button
                        PAPButton(
                            title: "Create Account",
                            backgroundColor: .blue) {
                                
                                registerViewModel.register()
                                //attempt to login
                                
                                //navigate to login view after acct created
                                //if registerViewModel.isSuccessful {
                                  //  destination = .loginView()
                            //    },
                            
                                
                            }
                            .offset(y:280)
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
  
