//
//  RoomPhotoPicker.swift
//  Roommate
//
//  Created by Aziz Kızgın on 15.04.2024.
//

import SwiftUI
import PhotosUI

struct RoomPhotoPicker: View {
    @Binding var imageDatas: [Data]
    @State private var images: [Image] = []
    @State private var roomPickerItems: [PhotosPickerItem] = []
    @State private var showPicker: Bool = false

    var body: some View {
        VStack{
            Spacer()
            Button(action: { showPicker.toggle() }) {
                photoDisplayView
            }
            .buttonStyle(.plain)
            .onAppear {
                setupAppearance()
            }
            .photosPicker(isPresented: $showPicker, selection: $roomPickerItems, maxSelectionCount: 4, matching: .images)
            .onChange(of: roomPickerItems) { _, newItems in
                Task{
                    await processNewItems(newItems)
                }
            }
            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button("Next") {
                    
                }
            }
        }
    }

    private var photoDisplayView: some View {
        VStack {
            if images.isEmpty {
                emptyPhotoView
            } else {
                filledPhotoView
            }
        }
    }

    private var emptyPhotoView: some View {
        VStack {
            Image(systemName: "photo.badge.plus")
                .font(.system(size: 150))
                .foregroundStyle(.accent)
        }
        .frame(height: 270)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.accent, lineWidth: 1.0)
        )
    }

    private var filledPhotoView: some View {
        TabView {
            ForEach(images.indices, id: \.self) { index in
                images[index]
                    .resizable()
                    .scaledToFit()
                    .frame(height: 270)

            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: 270)
    }

    private func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .accent
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.accent.withAlphaComponent(0.2)
    }

    private func processNewItems(_ newItems: [PhotosPickerItem]) async {
        images = []
        imageDatas = []
        for item in newItems{
            if let loadedImage = try? await item.loadTransferable(type: Image.self),
               let loadedData = try? await item.loadTransferable(type: Data.self) {
                images.append(loadedImage)
                imageDatas.append(loadedData)
            }
        }
    }
}

private func setupAppearance() {
  UIPageControl.appearance().currentPageIndicatorTintColor = .accent
  UIPageControl.appearance().pageIndicatorTintColor = UIColor.accent.withAlphaComponent(0.2)
}

#Preview {
    NavigationStack{
        RoomPhotoPicker(imageDatas: .constant([]))
    }
}
