//
//  TabBarView.swift
//  CustomShop
//
//  Created by Evgeniy K on 14.09.2024.
//

import SwiftUI

struct TabBarView: View {

    @Binding var isAdmin: Int // 0 - Admin, 1.. - User
    @Binding var index: Int
    @State var aminationIndex: Int = 0

    let adminImages = ["house.fill", "square.grid.2x2.fill", "plus", "gear"]
    let userImages = ["house.fill", "square.grid.2x2.fill", "heart", "person"]

    var body: some View {

        let images = isAdmin == 0 ? adminImages : userImages

        ZStack {
            Rectangle()
                .foregroundStyle(.indigo)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack {
                HStack {
                    ForEach(images.indices, id: \.self) { imageTag in
                        Button {
                            self.index = imageTag
                            aminationIndex = imageTag
                        } label: {
                            Image(systemName: images[imageTag])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .padding(30)
                                .foregroundStyle(aminationIndex == imageTag ? .black : .white)
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: aminationIndex)
        .frame(height: 100)
    }
}

#Preview {
    TabBarView(isAdmin: .constant(1), index: .constant(0))
}
