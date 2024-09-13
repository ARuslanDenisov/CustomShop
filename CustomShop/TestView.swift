//
//  TestView.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import SwiftUI

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
        }
    }
}

#Preview {
    TestView()
}
