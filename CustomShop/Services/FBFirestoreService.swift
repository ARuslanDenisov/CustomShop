//
//  FBFirestoreService.swift
//  CustomShop
//
//  Created by Руслан on 09.09.2024.
//

import Foundation
import FirebaseFirestore


class FBFirestoreService {
    static let shared = FBFirestoreService(); private init () { }
    let db = Firestore.firestore()
    
    //папки с файлами
    var usersRef: CollectionReference { db.collection("users") }
    var favoritesRef: CollectionReference { db.collection("favorites") }
    var productRef: CollectionReference { db.collection("products") }
    var shopRef: CollectionReference { db.collection("shop") }
    var productBucketRef: CollectionReference { db.collection("productsBucket") }
    var bannersRef: CollectionReference { db.collection("banners") }
    var categoryRef: CollectionReference { db.collection("category") }
    var optionsRef: CollectionReference { db.collection("options") }
    
    
    
    
//     CRUD operations
    
//    create
//    func addNewUser (newUser: UserModel) async throws {
//        do {
//            try await usersRef.document(newUser.id).setData(newUser.representation)
//        } catch {
//            print("add new user FB error")
//        }
//    }
//    
//    Add product
    
    func addNewProduct (_ newProduct: ProductModel) async throws {
           do {
               try await productRef.document(newProduct.id).setData(newProduct.representation)
           } catch {
               print("add new user FB error")
           }
       }
   
    //read
    
//    func getUser (userId: String) async throws -> UserModel {
//        let snapshot = try await usersRef.document(userId).getDocument()
//        guard var user = try await UserModel(qdSnap: snapshot) else { throw NetworkError.badData }
//        user.favorites = try await getUserFavorites(userId: userId)
//        return user
//    }
//    
//    func getUserFavorites (userId: String) async throws -> [StationModel] {
//        let snapshot = try await favoritesRef.document(userId).collection("favorites").getDocuments()
//        let docs = snapshot.documents
//        var favorites = [StationModel]()
//        for doc in docs { if let station = StationModel(qdSnap: doc) { favorites.append(station) } }
//        return favorites
//    }
//    
//    //update
//    
//    func updateUser (user: UserModel) async throws {
//        do {
//            try await usersRef.document(user.id).setData(user.representation)
//            try await updateFavorites(user: user)
//        } catch {
//            throw error
//        }
//    }
//    
//    func updateFavorites(user: UserModel ) async throws {
//        do {
//            try await favoritesRef.document(user.id).delete()
//            for station in user.favorites {
//                try await favoritesRef.document(user.id).collection("favorites").document("\(station.id)").setData(station.representation)
//            }
//            print("favorites in")
//        } catch {
//            print("favorites in error")
//            throw error
//        }
//    }
//    
//    //delete
//    
//    func deleteFavoriteStation (user: UserModel, station: StationModel) async throws {
//        do {
//            try await favoritesRef.document(user.id).collection("favorites").document(station.id).delete()
//        } catch {
//            print("favorites in error")
//            throw error
//        }
//    }
//    
//    func deleteUser (user: UserModel) async throws {
//        do {
//            try await usersRef.document(user.id).delete()
//            try await favoritesRef.document(user.id).delete()
//        } catch {
//            print("problem with delete user")
//            throw error
//        }
//    }
//    
//    func deleteFavorites (user: UserModel) async throws {
//        do {
//            try await favoritesRef.document(user.id).delete()
//        } catch {
//            print("problem with delete favorite")
//            throw error
//        }
//    }
//    
    
}

