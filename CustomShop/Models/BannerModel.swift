//
//  BannerModel.swift
//  CustomShop
//
//  Created by Evgeniy K on 12.09.2024.
//

import Foundation
import FirebaseFirestore

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
    init?(qdSnap: DocumentSnapshot) async throws {
        guard let data = qdSnap.data() else { return nil }
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let description = data["description"] as? String,
              let bannerColor = data["bannerColor"] as? String,
              let bannerPicture = data["bannerPicture"] as? String,
              let productID = data["productID"] as? String else { return nil }
        self.id = id
        self.name = name
        self.description = description
        self.bannerColor = bannerColor
        self.productID = productID
        self.bannerPicture = bannerPicture
    }
    
}
