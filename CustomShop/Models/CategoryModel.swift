//
//  CategoryModel.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import Foundation
import FirebaseFirestore

struct CategoryModel: Codable, Identifiable {
    let id: String
    let name: String
    let pictureId: String
}

extension CategoryModel {
    var representation: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["name"] = self.name
        dict["pictureId"] = self.pictureId
        return dict
    }
    
    // инициализатор через документ
    init?(qdSnap: DocumentSnapshot) async throws {
        guard let data = qdSnap.data() else { return nil }
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let pictureId = data["pictureId"] as? String else { return nil }
        self.id = id
        self.name = name
        self.pictureId = pictureId
    }

}
