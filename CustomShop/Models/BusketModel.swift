//
//  BusketModel.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import Foundation


struct BusketModel: Identifiable, Codable {
    var id: String = ""
    var products: [ProductBucketModel] = []
}
