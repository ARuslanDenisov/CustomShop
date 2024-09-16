//
//  LoginView.swift
//  CustomShop
//
//  Created by Юрий on 15.09.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Text("Welcome Back!")
                        .font(.title)
                        .bold()
                    Text("Log in to your Account")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .padding()
                
                ImputView(text: $email, title: "Email Address", placeholder: "Enter your email")
                    .autocapitalization(.none)
                
                ImputView(text: $password, title: "Password", placeholder: "Must be at least 8 characters", isSecureField: true)
                    .autocapitalization(.none)
                
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
                Spacer()
                
                HStack{
                    Text("Don't Have Any Account?")
                    NavigationLink {
                        RegistrationView()
                    } label: {
                        Text("Sign Up now")
                            .foregroundStyle(.red)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
