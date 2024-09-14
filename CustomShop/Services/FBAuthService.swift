//
//  FBAuthService.swift
//  CustomShop
//
//  Created by Руслан on 09.09.2024.
//

import Foundation
import Firebase
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}

final class FBAuthService {
    static let shared = FBAuthService()
    private init() {}
    var currentUser: User?
    
    //    func registerNewUser(user: UserData) {
    //        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, err in
    //            guard err == nil else {
    //                print(err?.localizedDescription ?? "error")
    //                return
    //            }
    ////            result?.user.sendEmailVerification()
    //
    //            }
    //        }
    //    }
    
    func signUp(email: String, password: String) async throws -> Bool {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentUser = result.user
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    func signIn (email: String, password: String ) async throws -> Bool {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentUser = result.user
            return true
        } catch {
            print("wrong email or password")
        }
        return false
    }
    
    func getAuthenticationUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
}


//struct UserData {
//    var name: String
//    var email: String
//    var password: String
//}
