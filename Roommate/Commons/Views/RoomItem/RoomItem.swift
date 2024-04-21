//
//  RoomItem.swift
//  Roommate
//
//  Created by Aziz Kızgın on 19.04.2024.
//

import SwiftUI

struct RoomItem: View {
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    let room: RoomProtocol
    @State private var imageDatas: [Data] = []
    var body: some View {
        VStack{
            RoomImages(imageDatas: imageDatas)
                .frame(height: idiom == .pad ? 500 :270)
            VStack(spacing: 10){
                RoomAddressInfo(address: room.address)
                    .font(.title3)
                    .fontWeight(.semibold)
                Divider()
                RoomProps(price: room.price, size: room.size, roomCount: room.roomCount, bathCount: room.bathCount)
            }
            .padding()
        }
        .onAppear{
            Task {
                if !room.images.isEmpty, imageDatas.isEmpty, let firstImage = room.images.first {
                    ImageManager.shared.convertStringToImageData(for: firstImage, completion: { data in
                        if let data {
                            self.imageDatas.append(data)
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    RoomItem(room: testRoom)
}
