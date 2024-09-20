//
//  RegisterView.swift
//  CustomShop
//
//  Created by Юрий on 13.09.2024.
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
                    ImputView(text: $password, title: "Password", placeholder: "Must be at least 8 characters", isSecureField: true)
            ZStack(alignment: .trailing) {
                ImputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Must be at least 8 characters", isSecureField: true)
                if !password.isEmpty && !confirmPassword.isEmpty {
                    if password == confirmPassword {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.systemGreen))
                    } else {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.systemRed))
                    }
                }
            }
                    Button {
                        Task {
                            await authViewModel.signUp()
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
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1 : 0.5)
            
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

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 7
        && confirmPassword == password
        && !name.isEmpty
    }
}

#Preview {
    RegistrationView()
}
