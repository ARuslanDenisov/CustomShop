//
//  FBFirestoreService.swift
//  CustomShop
//
//  Created by Руслан on 09.09.2024.
//

import Foundation
import FirebaseFirestore


class FBFirestoreService {
    static let shared = FBFirestoreService(); private init () { }
    let db = Firestore.firestore()
    
    //папки с файлами
    var usersRef: CollectionReference { db.collection("users") } // хранятся юзеры
    var ordersRef: CollectionReference { db.collection("orders") } // хранятся заказы
    var productRef: CollectionReference { db.collection("products") } // хранятся продукты
    var shopRef: CollectionReference { db.collection("shop") } // хранятся настройки магаза
    var orderProductRef: CollectionReference { db.collection("orderProduct") } // хранятся позиции заказов (отдельно чтоб если что апдейтить)
    var bannersRef: CollectionReference { db.collection("banners") } // хранятся баннеры (отдельно чтоб апдейтить удобнее было)
    var categoryRef: CollectionReference { db.collection("category") } // хранятся категории для магаза
    var optionsRef: CollectionReference { db.collection("options") } // хранятся опционалы каждого товара (опять же для удобства апдейта, потом мб поменяем )
    
    
    
    
//     CRUD operations
    //MARK: create
    // Добавляем нового юзера
    func addNewUser (newUser: UserModel) async throws {
        do {
            try await usersRef.document(newUser.id).setData(newUser.representation)
        } catch {
            print("add new user FB error")
        }
    }
    
    // Добавляем новый продукт
    
    func addNewProduct (_ newProduct: ProductModel) async throws {
           do {
               try await productRef.document(newProduct.id).setData(newProduct.representation)
               for option in newProduct.options {
                   try await addNewOption(option)
               }
               //TODO: update shop
           } catch {
               print("add new product FB error")
           }
       }
    func addNewOption (_ option: OptionModel) async throws {
        do {
            try await optionsRef.document(option.id).setData(option.representation)
        } catch {
            print("add new option FB error")
        }
    }
    // Добавляем новый заказ на сервер
    func addNewOrder(_ order: OrderModel) async throws {
        do {
            try await ordersRef.document(order.id).setData(order.representation)
            for product in order.products {
                try await addNewOrderProduct(product)
            }
            //TODO: update Shop and update User
        } catch {
            print ("add new order FB Error")
        }
    }
    //Добавляем отдельные позиции заказа
    func addNewOrderProduct (_ product: ProductOrderModel) async throws {
        do {
            try await orderProductRef.document(product.id).setData(product.representation)
        } catch {
            print ("add new order FB Error")
        }
    }
    //Добавить новый магазин - опция для админки только!
    func addNewShop (_ shop: ShopModel) async throws {
        do {
            try await shopRef.document(shop.id).setData(shop.representation)
        } catch {
            print ("add new shop FB Error")
        }
    }
    // новый баннер
    func addNewBanner (_ banner: BannerModel) async throws {
        do {
            try await bannersRef.document(banner.id).setData(banner.representation)
            //TODO: update Shop
        } catch {
            print ("add new banner FB Error")
        }
    }
    // Добавляем категорию в магаз
      func addNewCategory(_ category: CategoryModel) async throws {
          do {
              try await categoryRef.document(category.id).setData(category.representation)
              //TODO: update shop
          } catch {
              print ("add new category fb Error")
          }
      }
    
    //MARK: read
    
    func getUser (userId: String) async throws -> UserModel {
        let snapshot = try await usersRef.document(userId).getDocument()
        guard var user = try await UserModel(qdSnap: snapshot) else { throw NetworkError.badData }
        guard let data = snapshot.data() else { throw NetworkError.badData}
        guard let favoritesStr = data["favorites"] as? [String],
              let ordersStr = data["orders"] as? [String] else { throw NetworkError.badData }
        //TODO: Get fav and get orders
        //get favorites
//        try await user.favorites = getUserFavorites(favoritesStr)
        return user
    }
    
//    func getProduct(id: String) async throws -> ProductModel {
//        let snapshot = try await productRef.document(id).getDocument()
//        guard var product = try await ProductModel(qdSnap: snapshot) else { throw NetworkError.badData }
//    }
//    
//    func getUserFavorites(_ favs: [String]) async throws -> [ProductModel] {
//        var favorites: [ProductModel] = []
//        for fav in favs {
//            let product = try await getProduct(id: fav)
//            favorites.append(product)
//        }
//        return favorites
//    }
//    func getUserFavorites (userId: String) async throws -> [StationModel] {
//        let snapshot = try await favoritesRef.document(userId).collection("favorites").getDocuments()
//        let docs = snapshot.documents
//        var favorites = [StationModel]()
//        for doc in docs { if let station = StationModel(qdSnap: doc) { favorites.append(station) } }
//        return favorites
//    }
//    
    //update
    
//    func updateFavorites(user: UserModel ) async throws {
//        do {
//            for favorite in user.favorites {
//                try await usersRef.document(user.id).collection("favorites").document("\(favorite.id)").setData(favorite.representation)
//            }
//        } catch {
//            throw error
//        }
//    }
//
//    func updateUser (user: UserModel) async throws {
//        do {
//            try await usersRef.document(user.id).setData(user.representation)
//            try await updateFavorites(user: user)
//        } catch {
//            throw error
//        }
//    }
//    
//    func updateFavorites(user: UserModel ) async throws {
//        do {
//            try await favoritesRef.document(user.id).delete()
//            for station in user.favorites {
//                try await favoritesRef.document(user.id).collection("favorites").document("\(station.id)").setData(station.representation)
//            }
//            print("favorites in")
//        } catch {
//            print("favorites in error")
//            throw error
//        }
//    }
//    
//    //delete
//    
//    func deleteFavoriteStation (user: UserModel, station: StationModel) async throws {
//        do {
//            try await favoritesRef.document(user.id).collection("favorites").document(station.id).delete()
//        } catch {
//            print("favorites in error")
//            throw error
//        }
//    }
//    
//    func deleteUser (user: UserModel) async throws {
//        do {
//            try await usersRef.document(user.id).delete()
//            try await favoritesRef.document(user.id).delete()
//        } catch {
//            print("problem with delete user")
//            throw error
//        }
//    }
//    
//    func deleteFavorites (user: UserModel) async throws {
//        do {
//            try await favoritesRef.document(user.id).delete()
//        } catch {
//            print("problem with delete favorite")
//            throw error
//        }
//    }
//    
    
}

enum NetworkError: Error {
    case badData
}
