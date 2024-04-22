//
//  SavedRoomsView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 8.04.2024.
//

import SwiftUI
import SwiftData
struct SavedRoomsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var savedRooms: [SavedRoom]
    var body: some View {
        Group {
            if savedRooms.isEmpty {
                EmptyListView(title: "No room saved yet")
            }
            else {
                ScrollView{
                    ForEach(savedRooms, id: \.id) { room in
                        NavigationLink(value: room){
                                RoomItem(room: room)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .padding(.vertical)
                    }
                }
                .navigationDestination(for: SavedRoom.self, destination: { room in
                    RoomDetailView(room: room, inSavedView: true)
                })
            }
        }
        .navigationTitle("Saved Rooms")
    }
}

#Preview {
    MainActor.assumeIsolated {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: SavedRoom.self, configurations: config)

        let room = SavedRoom(from: testRoom)
        let room2 = SavedRoom(from: testRoom2)
        container.mainContext.insert(room)
        container.mainContext.insert(room2)
        
        return NavigationStack {
            SavedRoomsView()
                .modelContainer(container)
        }
    }
}
