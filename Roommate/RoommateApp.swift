//
//  RoommateApp.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import SwiftUI
import SwiftData

@main
struct RoommateApp: App {
    var modelContainer: ModelContainer = {
        let schema = Schema([
            AppUser.self,
            SavedRoom.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
