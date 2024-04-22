//
//  UserPhotoPicker.swift
//  Roommate
//
//  Created by Aziz Kızgın on 9.04.2024.
//
import SwiftUI
import PhotosUI

struct UserPhotoPicker: View {
    @Binding var image: String
    var isImageLoading = false
    @State private var userPickerItem: PhotosPickerItem?
    @State private var isLoading: Bool = false
    @State private var showPicker: Bool = false
    @State private var showError: Bool = false
    private let imageManager = ImageManager.shared
    var body: some View {
        Button(action: {showPicker.toggle()}, label: {
            ProfilePicture(image: image, imageSize: .large,isLoading: isLoading)
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50)
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.accent, lineWidth: 4))
                        .padding(.trailing)
                      
                }
       
        })
        .buttonStyle(.plain)
        .alert("Cannot convert image", isPresented: $showError){
            Button("Okay", role: .cancel) {}
        }
        .photosPicker(isPresented: $showPicker, selection: $userPickerItem)
        .onChange(of: userPickerItem) { _ , newItem in
            Task {
                isLoading = true
                if let loadedData = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: loadedData)
                {
                    imageManager.convertImageToString(for: uiImage) { base64String in
                        if let base64String = base64String {
                            image = base64String
                        }
                        isLoading = false
                    }
                }
            }
        }
    }
}

#Preview {
    UserPhotoPicker(image: .constant(""))
}
