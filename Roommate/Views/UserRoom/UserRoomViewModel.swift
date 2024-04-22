//
//  UserRoomViewModel.swift
//  Roommate
//
//  Created by Aziz Kızgın on 22.04.2024.
//

import Foundation
import SwiftUI

@Observable class UserRoomViewModel {
    var room: Room?
    var isLoading: Bool = false
    var showError: Bool = false
    var errorText: String = ""
    var showDeleteAlert: Bool = false
    
    func getRoom(userId: String) {
        isLoading = true
        UserManager.shared.getUserRooms(userId: userId) { [weak self] result in
            defer {
                self?.isLoading = false
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let room):
                    self?.room = room
                case .failure(let error):
                    print(error)
                    self?.setError(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteRoom() {
        guard let roomId = room?.id else {return}
        isLoading = true
        RoomManager.shared.deleteRoom(id: roomId) { [weak self] result in
            defer {
                self?.isLoading = false
            }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.room = nil
                case .failure(let error):
                    print(error)
                    self?.setError(error.localizedDescription)
                }
            }
        }
    }
    
    private func setError(_ message: String){
        self.showError.toggle()
        self.errorText = message
    }
}
