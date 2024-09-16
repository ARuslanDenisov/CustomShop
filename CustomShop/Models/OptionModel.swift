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
    
    var stringRepresentation: String {
        "id:\(id),name:\(name),amount:\(amount)"
    }
    init?(string: String) {
        let components = string.split(separator: ",")
        guard components.count == 3,
              let idPart = components.first(where: { $0.hasPrefix("id:") }),
              let namePart = components.first(where: { $0.hasPrefix("name:") }),
              let amountPart = components.first(where: { $0.hasPrefix("amount:") }),
              let id = idPart.split(separator: ":").last?.trimmingCharacters(in: .whitespacesAndNewlines),
              let name = namePart.split(separator: ":").last?.trimmingCharacters(in: .whitespacesAndNewlines),
              let amountString = amountPart.split(separator: ":").last?.trimmingCharacters(in: .whitespacesAndNewlines),
              let amount = Int(amountString)
        else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.amount = amount
        
    }
}
