//
//  BusketModel.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import Foundation


struct OrderModel: Identifiable, Codable {
    var id: String
    var city: String
    var address: String
    var postcode: String
    var userId: String
    var description: String
    var stateOfDelievery: Int //0 - доставлено, 1 - в процессе, 2 - в обработке
    var products: [ProductOrderModel]
}
