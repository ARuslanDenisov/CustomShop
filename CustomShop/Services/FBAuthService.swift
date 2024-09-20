//
//  FBAuthService.swift
//  CustomShop
//
//  Created by Руслан on 09.09.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct AuthDataResultModel {
    let id: String
    let email: String?
    let name: String?
    
    init(user: User) {
        self.id = user.uid
        self.email = user.email
        self.name = user.displayName
    }
}



final class FBAuthService {
    static let shared = FBAuthService()
    private init() {}
    var currentUser: User?
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentUser = result.user
            await fetchUser()
        } catch {
            print("Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    func signUp(withEmail email: String, password: String, name: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentUser = result.user
//            let user = User(id: result.user.uid, name: name, email: email)
//            let encodedUser = try Firestore.Encoder().encode(user)
//            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("Failed to login user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
//            self.userSession = nil
//            self.currentUser = nil
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
            try await self.currentUser?.delete()
            self.currentUser = nil
        } catch {
            print("User account failed to delete with error: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
//        self.currentUser = try? snapshot.data(as: User.self)
        print("Current user is \(String(describing: self.currentUser))")
    }
    
    func resetPassword(withEmail email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
}

//extension FBAuthService {
//
//    @discardableResult
//    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
//        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
//        return try await signIn(credential: credential)
//    }
//
//    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
//        let authDataResult = try await Auth.auth().signIn(with: credential)
//        return AuthDataResultModel(user: authDataResult.user)
//    }
//}
