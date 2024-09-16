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
            // TODO: update product
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
        try await user.favorites = getUserFavorites(favoritesStr)
        try await user.orders = getOrders(ordersStr)
        return user
    }
    
    func getProduct(id: String) async throws -> ProductModel {
        let snapshot = try await productRef.document(id).getDocument()
        guard var product = try await ProductModel(qdSnap: snapshot) else { throw NetworkError.badData }
        //get photos and options
        guard let data = snapshot.data() else { throw NetworkError.badData}
        guard let optionsStr = data["options"] as? [String],
              let photosStr = data["photos"] as? [String] else { throw NetworkError.badData }
        try await product.options = getOptions(optionsStr)
        //TODO: Add photo!!
        return product
    }
    
    func getOptions(_ arrayId: [String] ) async throws -> [OptionModel] {
        var optionArray: [OptionModel] = []
        for id in arrayId {
            let snapshot = try await optionsRef.document(id).getDocument()
            guard let option = try await OptionModel(qdSnap: snapshot) else { throw NetworkError.badData }
            optionArray.append(option)
        }
        return optionArray
    }
    
    func getUserFavorites(_ favs: [String]) async throws -> [ProductModel] {
        var favorites: [ProductModel] = []
        for fav in favs {
            let product = try await getProduct(id: fav)
            favorites.append(product)
        }
        return favorites
    }
    
    func getOrders(_ array: [String]) async throws -> [OrderModel] {
        var orders: [OrderModel] = []
        for ord in array {
            
        }
        return orders
    }
    
    func getOrder(_ id: String) async throws -> OrderModel {
        let snapshot = try await ordersRef.document(id).getDocument()
        guard var order = try await OrderModel(qdSnap: snapshot) else { throw NetworkError.badData }
        guard let data = snapshot.data() else { throw NetworkError.badData}
        guard let productsStr = data["products"] as? [String] else { throw NetworkError.badData }
        try await order.products = getOrderProducts(productsStr)
        return order
    }
    
    func getOrderProducts (_ array: [String] ) async throws -> [ProductOrderModel] {
        var productArray: [ProductOrderModel] = []
        for productOrder in array {
            let snapshot = try await orderProductRef.document(productOrder).getDocument()
            guard let product = try await ProductOrderModel(qdSnap: snapshot) else { throw NetworkError.badData }
            productArray.append(product)
        }
        return productArray
    }
    func getShop(_ id: String) async throws -> ShopModel {
        let snapshot = try await productRef.document(id).getDocument()
        guard var shop = try await ShopModel(qdSnap: snapshot) else { throw NetworkError.badData }
        // banners and category
        guard let data = snapshot.data() else { throw NetworkError.badData}
        guard let bannersStr = data["banners"] as? [String],
              let categoriesStr = data["categories"] as? [String] else { throw NetworkError.badData }
        try await shop.banners = getBanners(bannersStr)
        try await shop.categories = getCategories(categoriesStr)
        return shop
    }
    
    func getBanners (_ arrayId: [String]) async throws -> [BannerModel] {
        var banners: [BannerModel] = []
        for id in arrayId {
            let snapshot = try await bannersRef.document(id).getDocument()
            guard let banner = try await BannerModel(qdSnap: snapshot) else { throw NetworkError.badData }
            banners.append(banner)
        }
        return banners
    }
    
    func getCategories (_ arrayId: [String]) async throws -> [CategoryModel] {
        var categories: [CategoryModel] = []
        for id in arrayId {
            let snapshot = try await categoryRef.document(id).getDocument()
            guard let category = try await CategoryModel(qdSnap: snapshot) else { throw NetworkError.badData }
            categories.append(category)
        }
        return categories
    }
    
    //MARK: update
    
    func updateUser (_ user: UserModel) async throws {
        do {
            try await usersRef.document(user.id).setData(user.representation)
        } catch {
            throw error
        }
    }
    func updateFavorites(_ user: UserModel ) async throws {
        do {
            for favorite in user.favorites {
                try await usersRef.document(user.id).collection("favorites").document("\(favorite.id)").setData(favorite.representation)
            }
        } catch {
            throw error
        }
    }
    func updateProduct(_ product: ProductModel ) async throws {
        do {
            try await productRef.document(product.id).setData(product.representation)
        } catch {
            throw error
        }
    }
    func updateShop(_ shop: ShopModel ) async throws {
        do {
            try await shopRef.document(shop.id).setData(shop.representation)
        } catch {
            throw error
        }
    }
    
    func updateBanner(_ banner: BannerModel ) async throws {
        do {
            try await bannersRef.document(banner.id).setData(banner.representation)
        } catch {
            throw error
        }
    }
    
    func updateOrder(_ order: OrderModel ) async throws {
        do {
            try await ordersRef.document(order.id).setData(order.representation)
        } catch {
            throw error
        }
    }
    func updateCategory(_ category: CategoryModel ) async throws {
        do {
            try await categoryRef.document(category.id).setData(category.representation)
        } catch {
            throw error
        }
    }
    func updateOption(_ option: OptionModel ) async throws {
        do {
            try await optionsRef.document(option.id).setData(option.representation)
        } catch {
            throw error
        }
    }
    
    //MARK: delete
    
    func deleteFavorite (user: UserModel, product: ProductModel) async throws {
        do {
            try await usersRef.document(user.id).collection("favorites").document(product.id).delete()
        } catch {
            print("favorites in error")
            throw error
        }
    }
    //
    func deleteUser (_ user: UserModel) async throws {
        do {
            try await usersRef.document(user.id).delete()
        } catch {
            print("problem with delete user")
            throw error
        }
    }
    //
    func deleteProduct (_ product: ProductModel) async throws {
        do {
            try await productRef.document(product.id).delete()
            //TODO: Update shop
        } catch {
            print("problem with delete product")
            throw error
        }
    }
    func deleteOrder (_ order: OrderModel) async throws {
        do {
            try await ordersRef.document(order.id).delete()
            //TODO: Update shop
        } catch {
            print("problem with delete order")
            throw error
        }
    }
    func deleteBanner (_ banner: BannerModel) async throws {
        do {
            try await bannersRef.document(banner.id).delete()
            //TODO: Update shop
        } catch {
            print("problem with delete banner")
            throw error
        }
    }
    func deleteCategory (_ category: CategoryModel) async throws {
        do {
            try await categoryRef.document(category.id).delete()
            //TODO: Update shop
        } catch {
            print("problem with delete category")
            throw error
        }
    }
    func deleteOption (_ option: OptionModel) async throws {
        do {
            try await optionsRef.document(option.id).delete()
            //TODO: Update product
        } catch {
            print("problem with delete option")
            throw error
        }
    } 
}

enum NetworkError: Error {
    case badData
}
