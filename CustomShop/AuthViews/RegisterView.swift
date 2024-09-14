//
//  RegisterView.swift
//  CustomShop
//
//  Created by Юрий on 13.09.2024.
//

import SwiftUI

struct RegisterView: View {
//    @StateObject var authViewModel = AuthViewModel()
    @State var name = ""
    @State var email = ""
    @State var password = ""
    
//   let authService = FBAuthService()
    
    var body: some View {
        VStack {
            Text("Register!")
                .font(.title)
                .bold()
            Text("Create Your New Account")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
        
        VStack(alignment: .leading) {
            Text("Full Name")
            TextField("Enter your name", text: $name)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            
            Text("Email Address")
            TextField("Enter your email", text: $email)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            
            Text("Password")
            TextField("Enter your password", text: $password)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
            
            Button {
//                authService.registerNewUser(user: UserData(name: name, email: email, password: password))
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.black)
                    Text("Next")
                        .foregroundStyle(.white)
                }
            }
            .frame(width: 360, height: 53)
            .padding(.vertical)
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
