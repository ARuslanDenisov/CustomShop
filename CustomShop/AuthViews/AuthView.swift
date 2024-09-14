//
//  AuthView.swift
//  CustomShop
//
//  Created by Юрий on 13.09.2024.
//

import SwiftUI

struct AuthView: View {
    @StateObject var authViewModel = AuthViewModel()
    @Binding var showAuthView: Bool
    
    var body: some View {
        VStack {
            Text(authViewModel.signInBool ? "Welcome Back!": "Register!")
                .font(.title)
                .bold()
            Text(authViewModel.signInBool ? "Log in to your Account" : "Create Your New Account")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
        
        VStack(alignment: .leading) {
            if !authViewModel.signInBool {
                VStack(alignment: .leading) {
                    Text("Full Name")
                    TextField("Enter your name", text: $authViewModel.name)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                }
            }
            
            Text("Email Address")
            TextField("Enter your email", text: $authViewModel.email)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            
            Text("Password")
            TextField("Must be at least 8 characters", text: $authViewModel.password)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            
            if authViewModel.signInBool {
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
            }
            
            Button {
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.black)
                    Text(authViewModel.signInBool ? "Sign In" : "Sign up")
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
                Text(authViewModel.signInBool ? "Don't Have Any Account?" : "Already Have Any Account?")
                Button {
                    authViewModel.signInBool.toggle()
                } label: {
                    Text(authViewModel.signInBool ? "Sign Up now" : "Sign In")
                        .foregroundStyle(.red)
                }
            }
        }
        .padding()
        .animation(.easeInOut, value: authViewModel.signInBool)
    }
}

#Preview {
    AuthView(showAuthView: .constant(true))
}
