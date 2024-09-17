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
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
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
                    Button {
                        authViewModel.resetPassword(with: email)
                    } label: {
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundStyle(.red)
                    }
                    .alert(isPresented: $authViewModel.showResetPasswordAlert) {
                        Alert(
                            title: Text("Reset password"),
                            message: Text(authViewModel.messageResetPassword),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                
                Button {
                    Task {
                        try await authViewModel.signIn(withEmail: email, password: password)
                    }
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
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1 : 0.5)
                .alert(isPresented: $authViewModel.showInvalidUserCredentails) {
                    Alert(
                        title: Text("Invalid Login Credentials"),
                        message: Text("Please try again"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
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

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 7
    }
}

#Preview {
    LoginView()
}
