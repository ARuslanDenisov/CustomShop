//
//  ProductModel.swift
//  CustomShop
//
//  Created by Руслан on 11.09.2024.
//

import Foundation
import FirebaseFirestore

struct ProductModel: Identifiable {
    var id: String
    var name: String
    var description: String
    var price: Double
    var currency: String
    var options: [OptionModel]
    var categoryId: [String]
    var mainPhoto: String
    var photos: [PhotoModel]
 
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
        dict["photos"] = photos.map({ photo in
            photo.id
        })
        dict["categoryId"] = self.categoryId
        dict["options"] = options.map({ option in
            option.id
        })
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
              let photos = data["photos"] as? [String],
              let categoryId = data["categoryId"] as? [String],
              let currency = data["currency"] as? String else { return nil }
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.mainPhoto = mainPhoto
        self.photos = []
        self.currency = currency
        self.categoryId = categoryId
        self.options = []
    }

    // тестовый продукт для превью
    static func testProduct() -> ProductModel {
        let product = ProductModel(id: "205", 
                                   name: "Snake Jordan 8",
                                   description: "Lightweight sneakers. n/In these sneakers you are a star and will know many goals",
                                   price: 330.50,
                                   currency: "USD",
                                   options: [], categoryId: [],
                                   mainPhoto: "test",
                                   photos: [])
        return product
    }
    
}
