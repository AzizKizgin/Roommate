//
//  UserRoomView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 22.04.2024.
//

import SwiftUI
import SwiftData

struct UserRoomView: View {
    @Bindable private var userRoomVM = UserRoomViewModel()
    @Query private var user: [AppUser]
    var body: some View {
        ScrollView{
            if let room = userRoomVM.room
            {
                VStack {
                    NavigationLink(destination: RoomDetailView(room: room)){
                        RoomItem(room: room)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .padding(.vertical)
                    HStack(spacing: 20) {
                        NavigationLink(destination: CreateRoomView(room: room)){
                            Text("Update")
                                .frame(maxWidth: .infinity,alignment: .center)
                                .frame(height: 30)
                        }
                        Button(action: {self.userRoomVM.showDeleteAlert.toggle()}){
                            Text("Delete")
                                .frame(maxWidth: .infinity,alignment: .center)
                                .frame(height: 30)
                        }
                        .tint(.red)
                        .buttonBorderShape(.roundedRectangle)
                    }
                    .padding()
                    .font(.title2)
                    .buttonStyle(BorderedProminentButtonStyle())
                }
                .alert("Do you want to delete your room?", isPresented: $userRoomVM.showDeleteAlert) {
                    Button(action:  self.userRoomVM.deleteRoom, label: {
                        Text("Delete")
                    })
                }
            }
            else {
                ZStack{
                    Spacer().containerRelativeFrame([.horizontal, .vertical])
                    if userRoomVM.isLoading {
                        ProgressView()
                            .imageScale(.large)
                    }
                    else {
                        EmptyListView(title: "No room here")
                    }
                }
            }
        }
        .navigationTitle("Your Room")
        .refreshable {
            if let userId = user.first?.id {
                userRoomVM.getRoom(userId: userId)
            }
        }
        .onAppear{
            if let userId = user.first?.id {
                userRoomVM.getRoom(userId: userId)
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserRoomView()
    }
}
