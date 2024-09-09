//
//  ImageExtension.swift
//  CustomShop
//
//  Created by Руслан on 09.09.2024.
//

import SwiftUI

extension Image {
    func resizableToFit() -> some View {
        resizable()
            .scaledToFit()
    }

    func resizableToFill() -> some View {
        resizable()
            .scaledToFill()
    }
}

