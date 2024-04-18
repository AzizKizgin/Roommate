//
//  RoomPhotoPicker.swift
//  Roommate
//
//  Created by Aziz Kızgın on 15.04.2024.
//

import SwiftUI
import PhotosUI

struct RoomPhotoPicker: View {
    @Bindable var createRoomVM: CreateRoomViewModel
    @State private var imageDatas: [Data] = []
    @State private var showPicker: Bool = false

    var body: some View {
        VStack{
            Spacer()
            Button(action: { showPicker.toggle() }) {
                photoDisplayView
            }
            .buttonStyle(.plain)
            .photosPicker(isPresented: $showPicker, selection: $createRoomVM.roomPickerItems, maxSelectionCount: 4, matching: .images)
            .onChange(of: createRoomVM.roomPickerItems) { _, newItems in
                Task{
                    await processNewItems(newItems)
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                if !createRoomVM.roomPickerItems.isEmpty {
                    Button("Next") {
                        Task {
                            await self.createRoomVM.setImages()
                        }
                    }
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Back") {
                    self.createRoomVM.goScreen(.location)
                }
            }
        }
        .alert(createRoomVM.errorText, isPresented: $createRoomVM.showError){
            Button("Okay", role: .cancel) {}
        }
        .onAppear{
            if !createRoomVM.room.images.isEmpty {
                createRoomVM.room.images.forEach { image in
                    ImageManager.shared.convertStringToImageData(for: image, completion: { data in
                        if let data {
                            self.imageDatas.append(data)
                        }
                    })
                }
            }
        }
    }

    private var photoDisplayView: some View {
        VStack {
            if imageDatas.isEmpty {
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
            ForEach(imageDatas.indices, id: \.self) { index in
                if let uiImage = UIImage(data: imageDatas[index]) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 270)
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: 270)
    }

    private func processNewItems(_ newItems: [PhotosPickerItem]) async {
        imageDatas = []
        for item in newItems{
            if let loadedData = try? await item.loadTransferable(type: Data.self) {
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
        RoomPhotoPicker(createRoomVM: CreateRoomViewModel())
    }
}
