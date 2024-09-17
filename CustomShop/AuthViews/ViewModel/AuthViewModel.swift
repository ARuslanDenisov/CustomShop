//
//  AuthViewModel.swift
//  CustomShop
//
//  Created by Юрий on 15.09.2024.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var showInvalidUserCredentails = false
    @Published var messageResetPassword = ""
    @Published var showResetPasswordAlert = false
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
           await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("Failed to create user with error: \(error.localizedDescription)")
            showInvalidUserCredentails.toggle()
        }
    }
    
    func createUser(withEmail email: String, password: String, name: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: name, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("Failed to login user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAccount() async throws {
        if let uid = Auth.auth().currentUser?.uid {
            let userDocumentReference = Firestore.firestore().collection("users").document()
            try await userDocumentReference.delete()
        }
        
        do {
            try await self.userSession?.delete()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("User account failed to delete with error: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print("Current user is \(String(describing: self.currentUser))")
    }
    
    func resetPassword(with email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.messageResetPassword = "Failed to reset password with error: \(error.localizedDescription)"
            } else {
                self.messageResetPassword = "Password reset instructions sent to your email."
            }
            self.showResetPasswordAlert = true
        }
    }
}

