//
//  LoginView.swift
//  PopAPill
//
//  Created by jossyris on 2/26/25.
//


import SwiftUI


struct LoginView: View {
    @StateObject  var viewModel = LoginViewModel()
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                // Header view
                HeaderView(title: "Pop A Pill",
                           background: Color(red: 1.0, green: 0.71, blue: 0.76),
                           image: Image(systemName: "pill"))
                Spacer()
                        
            VStack{
                //Header icon
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width:130, height:130)
                    .bold(true)
                    .foregroundColor(
                        Color(red: 1.0, green: 0.91, blue: 0.96))
            }
            // where header is currently positioned
            .offset(y:-160)
                
            //shows an error message 
              
            
            VStack {
                if !viewModel.errorM.isEmpty
                {
                    Text(viewModel.errorM)
                        .foregroundColor(.red)
                }
                // text field for email
                TextField("Email Address", text: $viewModel.email)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .frame(height:45)
                    .cornerRadius(8)
                
                
                //text field for password
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .frame(height:45)
                    .cornerRadius(8)

                //toggle for user to select if a provider
                Toggle(isOn: $viewModel.isProvider){
                    Text("Are you a provider?")
                        .font(.headline)
                }
                .padding()

                //text field for provider ID if it is a provider
                if viewModel.isProvider{
                    TextField("Provider ID", text: $viewModel.providerID)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .frame(height:45)
                        .cornerRadius(8)
                }
                
                
                //Button for login
              
                PAPButton(
                    title: "Login",
                    backgroundColor: .blue) {
                    //attempt to login
                        viewModel.login()
                        
                    
                }
                .padding(.bottom, 10)
                
                
            }
            .padding()
            // Gray space is hidden
            .offset(y:-110)
            // Spacer()
            
            // Create a new account
            VStack{
                
                Text("New around here?")
                NavigationLink("Create An account",
                               destination: RegisterView())
            }
        }
        
        .padding()

        .background(Color(red: 1.0, green: 0.81, blue: 0.86))
    }
}
}
    


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView() 
    }
}
