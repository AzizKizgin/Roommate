//
//  MainView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 8.04.2024.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: TabScreen = TabScreen.Home
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag(TabScreen.Home)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SavedRoomsView()
                .tag(TabScreen.Saved)
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            MessagesView()
                .tag(TabScreen.Messages)
                .tabItem {
                    Label("Messages", systemImage: "message")
                }
            AccountView()
                .tag(TabScreen.Account)
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
        .toolbar(selectedTab == .Home ? .visible: .hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack{
        MainView()
    }
}
