//
//  OptionModel.swift
//  CustomShop
//
//  Created by Руслан on 11.09.2024.
//

import Foundation
import FirebaseFirestore


struct OptionModel: Identifiable, Codable {
    var id: String = ""
    var name: String = ""
    var amount: Int = 0
}
extension OptionModel {
    var representation: [String: Any] {
        var dict: [String: Any] = [:]
        dict["id"] = self.id
        dict["name"] = self.name
        dict["amount"] = self.amount
        return dict
    }
    init?(qdSnap: DocumentSnapshot) async throws {
        guard let data = qdSnap.data() else { return nil }
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let amount = data["amount"] as? Int else { return nil }
        self.id = id
        self.name = name
        self.amount = amount
    }
    
}
