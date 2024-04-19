//
//  RoomDetailView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 17.04.2024.
//

import SwiftUI
import SwiftData
import CoreLocation
import MapKit

struct RoomDetailView: View {
   
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
            TabView {
                ForEach(imageDatas.indices, id: \.self) { index in
                    if let uiImage = UIImage(data: imageDatas[index]) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 270)
                    }
                }
            }
            .overlay(alignment: .bottomTrailing, content: {
                Button(action: favoriteRoom, label: {
                    if let user = users.first , roomDetailVM.room.savedBy.contains(where: { savedBy in
                        savedBy.id == user.id
                    }){
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.accent)
                    }
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.white)
                        
                })
                .font(.title)
                .padding()
            })
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .frame(height: 270)
            VStack(spacing: 25){
                VStack{
                    Text("\(roomDetailVM.room.address.town), \(roomDetailVM.room.address.city)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(roomDetailVM.room.address.street), no: \(roomDetailVM.room.address.buildingNo) / \(roomDetailVM.room.address.apartmentNo) ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
                .font(.title3)
                .fontWeight(.semibold)
                HStack{
                    HStack{
                        Image(systemName: "turkishlirasign")
                            .font(.title3)
                            .foregroundStyle(Color.accentColor)
                        Text("\(String(roomDetailVM.room.price))")
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "ruler.fill")
                            .font(.title3)
                            .foregroundStyle(Color.accentColor)
                        Text("\(String(format: "%.0f", roomDetailVM.room.size)) m²")
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "bed.double.fill")
                            .font(.title3)
                            .foregroundStyle(Color.accentColor)
                        Text("\(String(roomDetailVM.room.roomCount))")
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "bathtub.fill")
                            .font(.title3)
                            .foregroundStyle(Color.accentColor)
                        Text("\(String(roomDetailVM.room.bathCount))")
                    }
                }
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
            VStack {
                let initialLocation: CLLocationCoordinate2D = .init(latitude: roomDetailVM.room.address.latitude, longitude: roomDetailVM.room.address.longitude)
                let position: MapCameraPosition = .camera(.init(centerCoordinate: initialLocation, distance: 2000))
                Map(position: .constant(position), interactionModes: .zoom){
                    Annotation("", coordinate: initialLocation) {
                        Image(systemName: "house.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white)
                            .background(Circle().foregroundStyle(.accent))
                    }
                }
            }
            .frame(height: 300)
        }
        .onAppear{
            roomDetailVM.setRoom(room: self.room)
        }
    }
}

#Preview {
    RoomDetailView(room: fakeRoom)
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

var fakeRoom = Room(id: 1, price: 1234, roomCount: 1, bathCount: 2, images: [image,image,image], size: 245, about: "It is room about It is room about It is room about It is room about It is room about It is room about It is room about It is room about It is room about It is room about It is room about It is room about It is room about It is room about", createdAt: "14.04.2024", owner: RoomUser(id: "ssss", firstName: "FirstName", lastName: "LastName", profilePicture: image, createdAt: "12.04.2024", about: "it is User About it is User About it is User About it is User About it is User About it is User About it is User About it is User About it is User About it is User About it is User About it is User About it is User About it is User About ", birthDate: "11.02.2004", job: "Student"), savedBy: [], address: RoomAddress(street: "23. Street", city: "City", town: "Town", country: "Country", buildingNo: "2", apartmentNo: "2", zipCode: "23453", latitude: 41.015137, longitude: 28.979530))


fileprivate var image: String = "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"
