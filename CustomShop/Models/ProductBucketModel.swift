//
//  ProductBucketModel.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import Foundation


struct ProductBucketModel: Codable, Identifiable {
    var id: String = ""
    var name: String = ""
    var idProduct: String = ""
    var options: OptionModel = OptionModel()
    var idPicture: String = ""
    var amount: Int = 0
    var price: Double = 0.0
    var currency: String = "USD"
}
