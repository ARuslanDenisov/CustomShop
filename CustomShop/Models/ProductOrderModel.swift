//
//  ProductBucketModel.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import Foundation


struct ProductOrderModel: Codable, Identifiable {
    var id: String
    var article: String
    var name: String
    var idShop: String
    var idProduct: String
    var options: OptionModel
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
        dict["options"] = self.options.representation
        dict["amount"] = self.amount
        dict["price"] = self.price
        dict["currency"] = self.currency
        dict["idShop"] = self.idShop
        dict["article"] = self.article
        return dict
    }
}
