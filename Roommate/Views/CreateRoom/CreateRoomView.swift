//
//  CreateRoomView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 15.04.2024.
//

import SwiftUI

struct CreateRoomView: View {
    @Environment(\.dismiss) private var dismiss
    var room: Room?
    @Bindable private var createRoomVM = CreateRoomViewModel()
    var body: some View {
        Group {
            if self.createRoomVM.isLoading && room != nil {
                ProgressView("Loading")
            }
            if let room = self.createRoomVM.responseRoom {
                RoomDetailView(room: self.createRoomVM.responseRoom!)
            }
            else {
                switch createRoomVM.screen {
                case .location:
                    RoomCreateLocationView(createRoomVM: createRoomVM)
                case .photo:
                    RoomPhotoPicker(createRoomVM: createRoomVM)
                case .detail:
                    RoomCreateDetailsView(createRoomVM: createRoomVM)
                }
            }
        }
        .onAppear{
            self.createRoomVM.setEditData(room: room)
        }
    }
}

#Preview {
    NavigationStack {
        CreateRoomView()
    }
}
