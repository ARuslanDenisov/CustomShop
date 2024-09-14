//
//  AuthViewModel.swift
//  CustomShop
//
//  Created by Юрий on 13.09.2024.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var signInBool = true
    
    @Published var userModel = UserModel()
    
    func signUp() async -> Bool {
        do {
            var result = false
            result = try await FBAuthService.shared.signUp(email: email, password: password)
            if let id = FBAuthService.shared.currentUser?.uid {
                userModel = UserModel(id: id, name: name, email: email)
            }
            return result
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func signIn() async -> Bool {
        do {
            var result: Bool = false
            result = try await FBAuthService.shared.signIn(email: email, password: password)
            return result
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
