//
//  LoginView.swift
//  CustomShop
//
//  Created by Юрий on 15.09.2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject var authViewModel = AuthViewModel()
//    @EnvironmentObject var authViewModel: AuthViewModel
    
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
                
                InputView(text: $email, title: "Email Address", placeholder: "Enter your email")
                    .autocapitalization(.none)
                
                InputView(text: $password, title: "Password", placeholder: "Must be at least 8 characters", isSecureField: true)
                    .autocapitalization(.none)
                
                HStack {
                    Text("Remember me")
                        .font(.subheadline)
                    Spacer()
                    Button {
                        authViewModel.resetPassword()
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
                        await authViewModel.signIn()
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
                HStack {
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .icon, state: .normal)) {
                        Task {
                            do {
                                try await authViewModel.signInGoogle()
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
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
//            .environmentObject(AuthViewModel())
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
