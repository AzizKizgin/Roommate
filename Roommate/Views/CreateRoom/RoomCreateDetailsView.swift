//
//  RoomCreateDetailsView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 15.04.2024.
//

import SwiftUI

struct RoomCreateDetailsView: View {
    @Bindable var createRoomVM: CreateRoomViewModel
    var body: some View {
        ScrollView{
            VStack(spacing: 50){
                VStack(spacing: 15){
                    Text("Address")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.accent)
                    FormInput("Street", text: $createRoomVM.room.address.street, icon: "map.circle.fill")
                    HStack{
                        FormInput("Floor No", text: $createRoomVM.room.address.apartmentNo, icon: "map.circle.fill")
                            .keyboardType(.numberPad)
                        FormInput("Building No", text: $createRoomVM.room.address.buildingNo, icon: "map.circle.fill")
                            .keyboardType(.numberPad)
                    }
                    HStack{
                        FormInput("Town", text: $createRoomVM.room.address.town, icon: "map.circle.fill")
                        FormInput("ZipCode", text: $createRoomVM.room.address.zipCode, icon: "map.circle.fill")
                            .keyboardType(.numberPad)
                    }
                    HStack{
                        FormInput("City", text: $createRoomVM.room.address.city, icon: "map.circle.fill")
                        FormInput("Country", text: $createRoomVM.room.address.country, icon: "map.circle.fill")
                    }
                }
                VStack(spacing: 15){
                    Text("Room")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.accent)
                    HStack{
                        FormInput("Price", text: $createRoomVM.room.price, icon: "turkishlirasign")
                            .keyboardType(.numberPad)
                            .keyboardType(.numberPad)
                        FormInput("Size", text: $createRoomVM.room.size, icon: "ruler.fill")
                            .keyboardType(.numberPad)
                    }
                    HStack{
                        FormInput("Room Count", text: $createRoomVM.room.roomCount, icon: "bed.double.fill")
                            .keyboardType(.numberPad)
                        FormInput("Bath Count", text: $createRoomVM.room.bathCount, icon: "bathtub.fill")
                            .keyboardType(.numberPad)
                    }
                    FormInput("About Room", text: $createRoomVM.room.about, icon: "info.circle.fill")
                        .multiline()
                }
            }
            .padding()
        }
        .alert(createRoomVM.errorText, isPresented: $createRoomVM.showError){
            Button("Okay", role: .cancel) {}
        }
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    self.createRoomVM.saveRoom()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Back") {
                    self.createRoomVM.goScreen(.photo)
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        RoomCreateDetailsView(createRoomVM: CreateRoomViewModel())
    }
}
