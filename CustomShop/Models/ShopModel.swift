//
//  ShopModel.swift
//  CustomShop
//
//  Created by Руслан on 14.09.2024.
//

import Foundation

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
}
