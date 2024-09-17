//
//  BasketView.swift
//  CustomShop
//
//  Created by Руслан on 09.09.2024.
//

import SwiftUI

struct BasketView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                HStack(spacing: 20) {
                    Image("test")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 100, height: 90)
                    
                    VStack(alignment: .leading) {
                        Text("Product 1")
                        Text("size")
                        Text("Price")
                    }
                    
                    Spacer()
                }
                .padding()
                .frame(width: .infinity, height: 120)
            }
            
            
            ZStack {
                Rectangle()
                    .foregroundStyle(.indigo)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .ignoresSafeArea()
            .frame(height: 345)
            .offset(y: 40)
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    BasketView()
}
