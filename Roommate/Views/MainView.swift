//
//  MainView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 8.04.2024.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag(0)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SavedRoomsView()
                .tag(1)
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            MessagesView()
                .tag(2)
                .tabItem {
                    Label("Messages", systemImage: "message")
                }
            AccountView()
                .tag(3)
                .tabItem {
                    Label("Settings", systemImage: "person")
                }
        }
    }
}

#Preview {
    MainView()
}
