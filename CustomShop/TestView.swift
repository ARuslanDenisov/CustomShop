//
//  TestView.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import SwiftUI
import FirebaseFirestore

struct TestView: View {
    let product = ProductModel(id: UUID().uuidString, name: "first", description: "", price: 121.12, currency: "USD", options: [OptionModel(id: UUID().uuidString, name: "XXXL", amount: 10)], categoryId: [UUID().uuidString], mainPhoto: UUID().uuidString, photos: [])
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                Task {
                    do {
                        try await FBFirestoreService.shared.addNewProduct(_: product)
                    } catch {
                        print("error")
                    }
                }
            } label: {
                Text("press me")
            }
            Button {
                Task {
                        let encoder = JSONEncoder()
                        do {
                            // Создаем тестовый объект TestProductModel и кодируем его в JSON
                            let testProduct = TestProductModel(id: "test", name: "test", description: "test", price: 2.0, currency: "test", categoryId: ["test"], mainPhoto: "test")
                            let jsonData = try encoder.encode(testProduct)
                            
                            // Преобразуем JSON данные в словарь [String: Any]
                            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                print(jsonObject)
                                // Асинхронно добавляем продукт в Firestore
                                try await FBFirestoreService.shared.addNewProductTest(jsonObject)
                                
                                // Успешно добавлено
                                print("Product successfully added!")
                            }
                        } catch let error {
                            // Обрабатываем и выводим ошибку
                            print("Error occurred: \(error.localizedDescription)")
                        }
                    }
            } label: {
                Text("test send Data")
            }
            
        }
    }

}

#Preview {
    TestView()
}
