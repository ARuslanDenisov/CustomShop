//
//  MainViewModel.swift
//  CustomShop
//
//  Created by Руслан on 27.09.2024.
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    @Published var tabIndex = 0
    @Published var isAdmin = false
}
