//
//  RoomImages.swift
//  Roommate
//
//  Created by Aziz Kızgın on 19.04.2024.
//

import SwiftUI

private struct SelectedImage: Identifiable {
    var id = UUID()
    var image: UIImage
}

struct RoomImages: View {
    @State private var selectedImage: SelectedImage?
    let imageDatas: [Data]
    var previewEnabled: Bool = false
    var body: some View {
        TabView {
            if imageDatas.isEmpty {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.gray)
                    .opacity(0.5)
            }
            else {
                ForEach(imageDatas.indices, id: \.self) { index in
                    if let uiImage = UIImage(data: imageDatas[index]) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .onTapGesture {
                                if previewEnabled {
                                    self.selectedImage = SelectedImage(image: uiImage)
                                }
                            }
                    }
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .fullScreenCover(item: $selectedImage) { selectedImage in
            VStack{
                Image(uiImage: selectedImage.image)
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxHeight: .infinity)
            .overlay(alignment: .topLeading){
                Button("Close") {
                    self.selectedImage = nil
                }
                .padding()
            }
        }
    }
}

#Preview {
    RoomImages(imageDatas: [])
}
