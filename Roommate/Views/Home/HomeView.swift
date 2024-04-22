//
//  HomeView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 8.04.2024.
//

import SwiftUI

struct HomeView: View {
    @Bindable private var homeVM = HomeViewModel()
    @State private var selectedRoom: RoomProtocol?
    @State private var showFilters: Bool = false
    var body: some View {
        ScrollView{
            VStack {
                if homeVM.rooms.isEmpty {
                    VStack {
                        Text("No data")
                    }
                }
                ForEach(homeVM.rooms, id: \.id) { room in
                    NavigationLink(value: room){
                        RoomItem(room: room)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .onAppear{
                        homeVM.loadMoreContent(currentItem: room)
                    }
                    .padding(.vertical)
                }
            }
            .padding()
        }
        .onChange(of: homeVM.queryObject, { oldValue, newValue in
            homeVM.refresh()
        })
        .onAppear {
            if homeVM.rooms.isEmpty {
                homeVM.getRooms()
            }
        }
        .refreshable {
            homeVM.refresh()
        }
        .alert(self.homeVM.errorText, isPresented: $homeVM.showError, actions: {
            Button("Okay") {}
        })
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showFilters.toggle()
                }
                label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.accent)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    CreateRoomView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.accent)
                }
            }
            
        }
        .fullScreenCover(isPresented: $showFilters, content: {
            FilterSelectionView(queryObject: $homeVM.queryObject)
        })
        .navigationDestination(for: Room.self, destination: { room in
            RoomDetailView(room: room)
        })
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
