//
//  AuthView.swift
//  CustomShop
//
//  Created by Юрий on 14.09.2024.
//

import SwiftUI

struct AuthView: View {
    @State var name = ""
    @State var email = ""
    @State var password = ""
    
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = true
    
    var body: some View {
        VStack {
            Text("Welcome Back!")
                .font(.title)
                .bold()
            Text("Log in to your Account")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            Text("Email Address")
            TextField("Enter your email", text: $email)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            
            Text("Password")
//            TextField("Must be at least 8 characters", text: $password)
//                .padding()
//                .background(Color.gray)
//                .cornerRadius(10)
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)  
            }
            
            
                HStack {
                    Text("Remember me")
                        .font(.subheadline)
                    Spacer()
                    NavigationLink {
                        
                    } label: {
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundStyle(.red)
                    }
                }
            
            Button {
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.black)
                    Text("Sign In")
                        .foregroundStyle(.white)
                }
            }
            .frame(width: 360, height: 53)
            .padding(.vertical)
            
            HStack {
                VStack{
                    Divider().background(.gray)
                }
                Text("Or")
                    .foregroundStyle(.gray)
                VStack{
                    Divider().background(.gray)
                }
            }
            
            //Google & Apple
            
            HStack{
                Text("Don't Have Any Account?")
                Button {
                    
                } label: {
                    Text("Sign Up now")
                        .foregroundStyle(.red)
                }
            }
        }
        .padding()
    }
}

#Preview {
    AuthView(text: .constant(""), title: "Email Address", placeholder: "Must be at least 8 characters")
}
