//
//  ContentView.swift
//  CustomShop
//
//  Created by Руслан on 09.09.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()
    var body: some View {
        ZStack {
            NavigationView {
                switch vm.tabIndex {
                case 0:
                    HomeView()
                case 1:
                    SearchProductView()
                case 2:
                    FavoritesView()
                case 3:
                    SettingsView()
                default:
                    HomeView()
                }
            }
            .navigationViewStyle(.stack)
            VStack {
                Spacer()
                TabBarView(isAdmin: 1, index: $vm.tabIndex)
            }
        }
        .padding()
    }
}

#Preview {
    MainView()
}
