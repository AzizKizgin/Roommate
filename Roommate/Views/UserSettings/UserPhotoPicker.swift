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
            if isLoading {
                ProgressView()
                    .controlSize(.large)
                    .tint(.accent)
            }
            else {
                ProfilePicture(image: image, imageSize: .large)
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
                    .onAppear{
                        print(image.count)
                    }
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
                        DispatchQueue.main.async {
                            defer {
                                isLoading = false
                            }
                            if let base64String {
                                self.image = base64String
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    UserPhotoPicker(image: .constant(""))
}
