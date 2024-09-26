//
//  ContentView.swift
//  CustomShop
//
//  Created by Руслан on 09.09.2024.
//

import SwiftUI

struct MainView: View {
//    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
//            if authViewModel.userSession != nil {
//                HomeView()
//            } else {
//                LoginView()
//            }
            LoginView()
        }
        
    }
}

//#Preview {
//    MainView()
//}
