//
//  RegistrationView.swift
//  CustomShop
//
//  Created by Юрий on 15.09.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text("Register!")
                    .font(.title)
                    .bold()
                Text("Create Your New Account")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .padding()
                
                    ImputView(text: $name, title: "Full Name", placeholder: "Enter your name")
                    ImputView(text: $email, title: "Email Address", placeholder: "Enter your email")
                    ImputView(text: $password, title: "Password", placeholder: "Must be at least 8 characters")
                    ImputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Must be at least 8 characters")
                    
                    Button {
                        Task {
                            try await authViewModel.createUser(withEmail: email, password: password, name: name)
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.black)
                            Text("Sign Up")
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(width: 360, height: 53)
                    .padding(.vertical)
            
            HStack{
                Text("Already Have Any Account?")
                Button {
                  dismiss()
                } label: {
                    Text("Sign In")
                        .foregroundStyle(.red)
                }
            }
                }
                .padding()
    }
}

#Preview {
    RegistrationView()
}
