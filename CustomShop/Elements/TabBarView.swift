//
//  TabBarView.swift
//  CustomShop
//
//  Created by Evgeniy K on 14.09.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @State var isAdmin: Int // 0 - Admin, 1 - User
    @Binding var index: Int
    @State var aminationIndex: Int = 0
    
    let adminImages = ["house.fill", "square.grid.2x2.fill", "plus", "gear"]
    let userImages = ["house.fill", "square.grid.2x2.fill", "heart", "person"]
    
    var body: some View {
        
        let images = isAdmin == 0 ? adminImages : userImages
        
        ZStack {
            Rectangle()
                .foregroundStyle(.purple.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack {
                HStack {
                    ForEach(images.indices, id: \.self) { imageTag in
                        
                        Image(systemName: images[imageTag])
                            .resizableToFit()
                            .frame(width: 25)
                            .padding(.horizontal, 23)
                            .foregroundStyle(aminationIndex == imageTag ? .black : .white)
                            .onTapGesture {
                                self.index = imageTag
                                aminationIndex = imageTag
                            }
                        
                    }
                }
            }
        }
        .animation(.easeInOut, value: aminationIndex)
        .frame(width: 340, height: 60)
    }
}

#Preview {
    TabBarView(isAdmin: 1, index: .constant(0))
}
