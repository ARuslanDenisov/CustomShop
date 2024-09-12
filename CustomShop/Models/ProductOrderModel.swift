//
//  ProductBucketModel.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import Foundation


struct ProductOrderModel: Codable, Identifiable {
    var id: String
    var name: String
    var idProduct: String
    var options: OptionModel
    var idPicture: String
    var amount: Int
    var price: Double
    var currency: String
}
