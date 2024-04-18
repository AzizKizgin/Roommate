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
            switch createRoomVM.screen {
            case .location:
                RoomCreateLocationView(createRoomVM: createRoomVM)
            case .photo:
                RoomPhotoPicker(createRoomVM: createRoomVM)
            case .detail:
                RoomCreateDetailsView(createRoomVM: createRoomVM)
            }
        }
        .onAppear{
            DispatchQueue.main.async {
                if let room {
                    let roomUpdate = RoomUpsertInfo(from: room)
                    self.createRoomVM.room = roomUpdate
                }
            }
        }
        .fullScreenCover(isPresented: .constant(self.createRoomVM.responseRoom != nil)){
            NavigationStack{
                RoomDetailView(room: self.createRoomVM.responseRoom!)
                    .toolbar(){
                        ToolbarItem(placement: .navigation) {
                            Button("Close") {
                                dismiss()
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateRoomView()
    }
}
