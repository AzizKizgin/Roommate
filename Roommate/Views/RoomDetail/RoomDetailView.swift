//
//  RoomDetailView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 17.04.2024.
//

import SwiftUI
import SwiftData

struct RoomDetailView: View {
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    let room: RoomProtocol
    @Environment(\.modelContext) private var modelContext
    @Bindable private var roomDetailVM: RoomDetailViewModel
    @State private var imageDatas: [Data] = []
    @Query private var users: [AppUser]
    @Query private var savedRooms: [SavedRoom]
    init(room: RoomProtocol) {
        self.room = room
        self._roomDetailVM = Bindable(RoomDetailViewModel(room: room))
    }
    var body: some View { 
        ScrollView{
            RoomImages(imageDatas: imageDatas,previewEnabled: true)
            .frame(height: idiom == .pad ? 500 :270)
            VStack(spacing: 25){
                HStack{
                    RoomAddressInfo(address: roomDetailVM.room.address)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Button(action: favoriteRoom, label: {
                        if let user = users.first , roomDetailVM.room.savedBy.contains(where: { savedBy in
                            savedBy.id == user.id
                        }){
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.accent)
                        }
                        Image(systemName: "heart")
                            .foregroundStyle(.accent)
                            
                    })
                    .font(.title)
                }
                Divider()
                RoomProps(price: roomDetailVM.room.price, size: roomDetailVM.room.size, roomCount: roomDetailVM.room.roomCount, bathCount: roomDetailVM.room.bathCount)
                Divider()
                VStack(spacing: 10){
                    Text("About Room")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.accent)
                    Text(roomDetailVM.room.about)
                    Divider()
                }
                VStack(spacing: 10){
                    Text("About Roommate")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.accent)
                    HStack(spacing: 20){
                        Group {
                            if !roomDetailVM.room.owner.profilePicture.isEmpty , let uiImage =  ImageManager.shared.convertStringToImage(for: roomDetailVM.room.owner.profilePicture) {
                                Image(uiImage: uiImage)
                                    .resizable()
                            }
                            else {
                                Image(systemName: "person.fill")
                                    .resizable()
                            }
                        }
                        .frame(width: 80, height: 80)
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.accent, lineWidth: 4))
                 
                        VStack{
                            Text("\(roomDetailVM.room.owner.firstName) \(roomDetailVM.room.owner.lastName)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(roomDetailVM.room.owner.job), \(Utils.getAge(from: roomDetailVM.room.owner.birthDate))")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text(roomDetailVM.room.owner.about)
                    Divider()
                }
            }
            .onAppear{
                Task {
                    if !roomDetailVM.room.images.isEmpty {
                        roomDetailVM.room.images.forEach { image in
                            ImageManager.shared.convertStringToImageData(for: image, completion: { data in
                                if let data {
                                    self.imageDatas.append(data)
                                }
                            })
                        }
                    }
                }
            }
            .padding()
            RoomMap(address: roomDetailVM.room.address)
            .frame(height: idiom == .pad ? 500 :300)
        }
        .onAppear{
            roomDetailVM.setRoom(room: self.room)
        }
    }
}

#Preview {
    RoomDetailView(room: testRoom)
}

extension RoomDetailView {
    private func favoriteRoom() {
        self.roomDetailVM.favoriteRoom { favedRoom in
            guard let favedRoom else {return}
            if let savedRoom = savedRooms.first(where: { saved in
                saved.id == favedRoom.id
            }){
                modelContext.delete(savedRoom)
            }
            else {
                let room = SavedRoom(from: favedRoom)
                modelContext.insert(room)
            }
        }
    }
}
