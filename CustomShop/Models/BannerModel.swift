//
//  BannerModel.swift
//  CustomShop
//
//  Created by Evgeniy K on 12.09.2024.
//

import Foundation

struct BannerModel: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let bannerColor: String
    let bannerPicture: String
    let productID: String
}

extension BannerModel {
    var representation: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["name"] = self.name
        dict["description"] = self.description
        dict["bannerColor"] = self.bannerColor
        dict["bannerPicture"] = self.bannerPicture
        dict["productID"] = self.productID
        return dict
    }
}
