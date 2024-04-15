//
//  RoomCreateDetailsView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 15.04.2024.
//

import SwiftUI

struct RoomCreateDetailsView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 50){
                VStack(spacing: 15){
                    Text("Address")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.accent)
                    FormInput("Street", text: .constant(""), icon: "map.circle.fill")
                    HStack{
                        FormInput("Apartment No", text: .constant(""), icon: "map.circle.fill")
                        FormInput("Building No", text: .constant(""), icon: "map.circle.fill")
                    }
                    HStack{
                        FormInput("Town", text: .constant(""), icon: "map.circle.fill")
                        FormInput("ZipCode", text: .constant(""), icon: "map.circle.fill")
                    }
                    HStack{
                        FormInput("City", text: .constant(""), icon: "map.circle.fill")
                        FormInput("Country", text: .constant(""), icon: "map.circle.fill")
                    }
                }
                VStack(spacing: 15){
                    Text("Room")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.accent)
                    HStack{
                        FormInput("Price", text: .constant(""), icon: "turkishlirasign")
                        FormInput("Size", text: .constant(""), icon: "ruler.fill")
                    }
                    HStack{
                        FormInput("Room", text: .constant(""), icon: "bed.double.fill")
                        FormInput("Bath", text: .constant(""), icon: "bathtub.fill")
                    }
                    FormInput("About Room", text: .constant(""), icon: "info.circle.fill")
                        .multiline()
                }
            }
            .padding()
        }
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        RoomCreateDetailsView()
    }
}
