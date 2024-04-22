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
    @State private var showCreate: Bool = false
    var body: some View {
        ScrollView{
            if homeVM.rooms.isEmpty {
                ZStack{
                    Spacer().containerRelativeFrame([.horizontal, .vertical])
                    if homeVM.isLoading {
                        ProgressView("Loading")
                            .controlSize(.large)
                    }
                    else {
                        EmptyListView(title: "No rooms found")
                    }
                }
            }
            else {
                VStack {
                    ForEach(homeVM.rooms, id: \.id) { room in
                        NavigationLink(value: room){
                            RoomItem(room: room)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .onAppear{
                            Task {
                                await homeVM.loadMoreContent(currentItem: room)
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .padding()
            }
            
        }
        .onChange(of: homeVM.queryObject, { oldValue, newValue in
            Task {
                await homeVM.refresh()
            }
        })
        .refreshable {
            Task {
                await homeVM.refresh()
            }
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
                Button {
                    showCreate.toggle()
                }
                label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.accent)
                }
            }
        }
        .fullScreenCover(isPresented: $showCreate,onDismiss: {
            Task {
                await self.homeVM.refresh()
            }
        }, content: {
            NavigationStack {
                CreateRoomView()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {showCreate.toggle()}, label: {
                                Text("Cancel")
                            })
                        }
                    }
            }
        })
        .fullScreenCover(isPresented: $showFilters,onDismiss: {
            Task {
                await self.homeVM.refresh()
            }
        }, content: {
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
