//
//  RoomDetailViewModel.swift
//  Roommate
//
//  Created by Aziz Kızgın on 17.04.2024.
//

import Foundation

@Observable class RoomDetailViewModel {
    var room: RoomProtocol
    var isLoading: Bool = false
    
    init(room: RoomProtocol) {
         self.room = room
     }
    
    func setRoom(room: RoomProtocol) {
        self.room = room
    }
    
    func favoriteRoom(completion: @escaping (RoomProtocol?) -> Void) {
        self.isLoading = true
        RoomManager.shared.favoriteRoom(id: room.id) { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let room):
                    self?.room = room
                    completion(room)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
        }
    }
}
