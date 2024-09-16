//
//  ProductBucketModel.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import Foundation
import FirebaseFirestore

struct ProductOrderModel: Codable, Identifiable {
    var id: String
    var article: String
    var name: String
    var idShop: String
    var idProduct: String
    var option: OptionModel
    var idPicture: String
    var amount: Int
    var price: Double
    var currency: String
}

extension ProductOrderModel {
    var representation: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["name"] = self.name
        dict["idProduct"] = self.idProduct
        dict["idPicture"] = self.idPicture
        dict["option"] = self.option.representation
        dict["amount"] = self.amount
        dict["price"] = self.price
        dict["currency"] = self.currency
        dict["idShop"] = self.idShop
        dict["article"] = self.article
        return dict
    }
    init?(qdSnap: DocumentSnapshot) async throws {
        guard let data = qdSnap.data() else { return nil }
        guard let id = data["id"] as? String,
              let article = data["article"] as? String,
              let name = data["name"] as? String,
              let idShop = data["idShop"] as? String,
              let idProduct = data["idProduct"] as? String,
              let idPicture = data["idPicture"] as? String,
              let optionStr = data["option"] as? String,
              let amount = data["amount"] as? Int,
              let price = data["price"] as? Double,
              let currency = data["currency"] as? String else { return nil }
        guard let option = OptionModel(string: optionStr) else {return nil }
        self.id = id
        self.article = article
        self.name = name
        self.idShop = idShop
        self.idProduct = idProduct
        self.idPicture = idPicture
        self.amount = amount
        self.price = price
        self.currency = currency
        self.option = option
    }
}
