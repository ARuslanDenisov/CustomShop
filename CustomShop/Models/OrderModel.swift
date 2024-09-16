//
//  BusketModel.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import Foundation


struct OrderModel: Identifiable, Codable {
    var id: String
    var idShop: String
    var city: String
    var address: String
    var postcode: String
    var userId: String
    var description: String
    var stateOfDelievery: Int //0 - доставлено, 1 - в процессе, 2 - в обработке
    var products: [ProductOrderModel]
}

extension OrderModel {
    var representation: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["city"] = self.city
        dict["address"] = self.address
        dict["postcode"] = self.postcode
        dict["userId"] = self.userId
        dict["description"] = self.description
        dict["stateOfDelievery"] = self.stateOfDelievery
        dict["products"] = products.map{($0.id)}
        dict["idShop"] = self.idShop
        return dict
    }
    
}
