//
//  HomeView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 8.04.2024.
//

import SwiftUI

struct HomeView: View {
    @Bindable private var homeVM = HomeViewModel()
    var body: some View {
        ScrollView{
            ForEach(homeVM.rooms, id: \.id) { room in
                RoomItem(room: room) 
                    .onAppear{
                        homeVM.loadMoreContent(currentItem: room)
                    }
            }
        }
        .refreshable {
            homeVM.refresh()
        }
        .alert(self.homeVM.errorText, isPresented: $homeVM.showError, actions: {
            Button("Okay") {}
        })
        .onAppear {
            DispatchQueue.main.async {
                homeVM.isActive = true
            }   
        }
        .onDisappear {
            DispatchQueue.main.async { 
                homeVM.isActive = false
            }
        }
        .toolbar {
            if homeVM.isActive {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        FilterSelectionView(queryObject: $homeVM.queryObject)
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
        }
        
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
