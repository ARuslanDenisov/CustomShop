//
//  UserModel.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import Foundation
import FirebaseFirestore

struct UserModel: Identifiable {
    var id: String
    var name: String
    var lastName: String
    var email: String
    var birthday: Double
    var phone: String
    var accessLevel: Int // 0: admin , 1: user
    var favorites: [ProductModel]
    var orders: [OrderModel]
}


extension UserModel {
    // Это для того чтобы в фаерстор положить данные
    var representation: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["name"] = self.name
        dict["lastName"] = self.lastName
        dict["birthday"] = self.birthday
        dict["phone"] = self.phone
        dict["accessLevel"] = self.accessLevel
        return dict
    }
    
    // инициализатор через документ
    init?(qdSnap: DocumentSnapshot) async throws {
        guard let data = qdSnap.data() else { return nil }
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let lastName = data["lastName"] as? String,
              let email = data["email"] as? String,
              let birthday = data["birthday"] as? Double,
              let phone = data["phone"] as? String,
              let accessLevel = data["accessLevel"] as? Int else { return nil }
        self.id = id
        self.name = name
        self.lastName = lastName
        self.birthday = birthday
        self.email = email
        self.phone = phone
        self.accessLevel = accessLevel
        self.favorites = []
        self.orders = []
        //TODO: Добавить получение закладок и заказов
        //        self.favorites = try await FBFirestoreService.shared.getFavorites(userId: id)
        //        self.orders = try await FBFirestoreService.shared.getOrders(userId: id)
    }
}

