//
//  ShopModel.swift
//  CustomShop
//
//  Created by Руслан on 14.09.2024.
//

import Foundation
import FirebaseFirestore

struct ShopModel: Identifiable {
    var id: String
    var name: String
    var information: String
    var city: String
    var address: String
    var postcode: String
    var contactMail: String
    var contactPhone: String
    var idProducts: [String] // массив айдишников товаров
    var idOrders: [String] // массив заказов
    var idPicture: String // картинка магаза?
    var dateOfCreation: Double
    var banners: [BannerModel] // массив баннеров
    var categories: [CategoryModel] // массив категорий
    var ownerId: String
    var currency: String
}

extension ShopModel {
    var representation: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["name"] = self.name
        dict["information"] = self.information
        dict["city"] = self.city
        dict["address"] = self.address
        dict["postcode"] = self.postcode
        dict["contactMail"] = self.contactMail
        dict["postcode"] = self.postcode
        dict["idProducts"] = self.idProducts
        dict["idPicture"] = self.idPicture
        dict["dateOfCreation"] = self.dateOfCreation
        dict["ownerId"] = self.ownerId
        dict["currency"] = self.currency
        dict["idOrders"] = self.idOrders
        dict["banners"] = self.banners.map({ $0.id })
        dict["categories"] = self.categories.map({ $0.id })
        return dict
    }
    init?(qdSnap: DocumentSnapshot) async throws {
        guard let data = qdSnap.data() else { return nil }
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let information = data["information"] as? String,
              let city = data["city"] as? String,
              let address = data["address"] as? String,
              let postcode = data["postcode"] as? String,
              let contactMail = data["contactMail"] as? String,
              let contactPhone = data["contactPhone"] as? String,
              let idProducts = data["idProducts"] as? [String],
              let idOrders = data["idOrders"] as? [String],
              let idPicture = data["idPicture"] as? String,
              let dateOfCreation = data["dateOfCreation"] as? Double,
              let ownerId = data["ownerId"] as? String,
              let currency = data["currency"] as? String else { return nil }
        self.id = id
        self.name = name
        self.information = information
        self.city = city
        self.address = address
        self.postcode = postcode
        self.contactMail = contactMail
        self.contactPhone = contactPhone
        self.idProducts = idProducts
        self.idOrders = idOrders
        self.idPicture = idPicture
        self.dateOfCreation = dateOfCreation
        self.ownerId = ownerId
        self.currency = currency
        self.banners = []
        self.categories = []
        //TODO: Добавить получение фотографий и опций
//        self.options = try await FBFirestoreService.shared.getOptions(productId: id)
//        self.photos = try await FBFirestoreService.shared.getPhotos(productId: id)
    }

}
