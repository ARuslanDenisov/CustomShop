//
//  ProductModel.swift
//  CustomShop
//
//  Created by Руслан on 11.09.2024.
//

import Foundation
import FirebaseFirestore

struct ProductModel: Identifiable, Codable {
    var id: String = ""
    var name: String = ""
    var description: String = ""
    var price: Double = 0.0
    var currency: String = "USD"
    var options: [OptionModel] = []
    var mainPhoto: String = ""
    var photos: [String] = []
 
}

extension ProductModel {
    // Это для того чтобы в фаерстор положить данные
    var representation: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["name"] = self.name
        dict["description"] = self.description
        dict["price"] = self.price
        dict["currency"] = self.currency
        dict["mainPhoto"] = self.mainPhoto
        return dict
    }
    
    // инициализатор через документ
    init?(qdSnap: DocumentSnapshot) async throws {
        guard let data = qdSnap.data() else { return nil }
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let description = data["description"] as? String,
              let price = data["price"] as? Double,
              let mainPhoto = data["mainPhoto"] as? String,
              let currency = data["currency"] as? String else { return nil }
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.mainPhoto = mainPhoto
        self.currency = currency
        //TODO: Добавить получение фотографий и опций
//        self.options = try await FBFirestoreService.shared.getOptions(productId: id)
//        self.photos = try await FBFirestoreService.shared.getPhotos(productId: id)
    }
}
