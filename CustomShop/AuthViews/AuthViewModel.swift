//
//  AuthViewModel.swift
//  CustomShop
//
//  Created by Юрий on 13.09.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var name = ""
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var showInvalidUserCredentails = false
    @Published var messageResetPassword = ""
    @Published var showResetPasswordAlert = false
    
    func signIn() async {
        do {
            try await FBAuthService.shared.signIn(withEmail: email, password: password)
        } catch {
            print("Failed to create user with error: \(error.localizedDescription)")
            showInvalidUserCredentails.toggle()
        }
    }
    
    func signUp() async {
        do {
            try await FBAuthService.shared.signUp(withEmail: email, password: password, name: name)
        } catch {
            print("Failed to login user with error: \(error.localizedDescription)")
        }
    }
    
    func resetPassword()  {
        FBAuthService.shared.resetPassword(withEmail: email) { error in
            if let error = error {
                self.messageResetPassword = "Failed to reset password with error: \(error.localizedDescription)"
            } else {
                self.messageResetPassword = "Password reset instructions sent to your email."
            }
            self.showResetPasswordAlert = true
        }
    }
    
//    func signInGoogle() async throws {
//        guard let topVC = Utilites.shared.topViewController() else {
//            throw URLError(.cannotFindHost)
//        }
//
//        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
//
//        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
//            throw URLError(.badServerResponse)
//        }
//
//        let accessToken = gidSignInResult.user.accessToken.tokenString
//
//        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
//        try await FBAuthService.shared.signInWithGoogle(tokens: tokens)
//    }
}

