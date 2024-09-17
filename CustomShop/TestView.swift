//
//  TestView.swift
//  CustomShop
//
//  Created by Руслан on 12.09.2024.
//

import SwiftUI

struct TestView: View {
    let product = ProductModel(id: UUID().uuidString, name: "first", description: "", price: 121.12, currency: "USD", options: [OptionModel(id: UUID().uuidString, name: "XXXL", amount: 10)], categoryId: [UUID().uuidString], mainPhoto: UUID().uuidString, photos: [])
    let option = OptionModel(id: UUID().uuidString, name: "albert", amount: 3)
    let user = UserModel(id: UUID().uuidString, name: "Ivan", lastName: "Ivanov", email: "ivan@ivan.com", birthday: 4131212421, phone: "9031231292", accessLevel: 1,
                         favorites: [ProductModel(id: UUID().uuidString, name: "Nike", description: "aero", price: 131.21, currency: "RUB", options: [OptionModel(id: UUID().uuidString, name: "red", amount: 4)], categoryId: [UUID().uuidString], mainPhoto: "123", photos: [])],
                         orders: [OrderModel(id: UUID().uuidString, idShop: UUID().uuidString, city: "MSC", address: "12312", postcode: "12121", userId: UUID().uuidString, description: "test", stateOfDelievery: 0, products: [ProductOrderModel(id: UUID().uuidString, article: "12312412", name: "nike1", idShop: "", idProduct: "", option: OptionModel(), idPicture: "", amount: 1, price: 121.12, currency: "RUB")])])
    @State var testarray = [1,2,3,4,5]
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                testarray.removeAll{$0 == 5}
                print(testarray)
            } label: {
                Text("press me")
            }
        }
    }
  
}

#Preview {
    TestView()
}
