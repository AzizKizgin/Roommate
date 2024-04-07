//
//  ContentView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var users: [AppUser]
    var body: some View {
        NavigationStack{
            if users.first != nil {
                MainView()
            }
            else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
