//
//  BannerModel.swift
//  CustomShop
//
//  Created by Evgeniy K on 12.09.2024.
//

import Foundation

struct Banner: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let bannerColor: String
    let bannerPicture: String
    let productID: String
}

struct Banners: Codable {
    let banners: [Banner]
}
