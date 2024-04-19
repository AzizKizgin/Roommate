//
//  SavedRoom.swift
//  Roommate
//
//  Created by Aziz Kızgın on 10.04.2024.
//

import Foundation
import SwiftData

@Model
class SavedRoom : RoomProtocol {
    var id: Int
    var price: Double
    var roomCount: Int
    var bathCount: Int
    var images: [String]
    var size: Double
    var about: String
    var createdAt: String
    var updatedAt: String?
    var owner: RoomUser
    var savedBy: [RoomUser]
    var address: RoomAddress
    
    init(id: Int, price: Double, roomCount: Int, bathCount: Int, images: [String], size: Double, about: String, createdAt: String, updatedAt: String? = nil, owner: RoomUser, savedBy: [RoomUser], address: RoomAddress) {
        self.id = id
        self.price = price
        self.roomCount = roomCount
        self.bathCount = bathCount
        self.images = images
        self.size = size
        self.about = about
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.owner = owner
        self.savedBy = savedBy
        self.address = address
    }
    
    init(from room: RoomProtocol){
        self.id = room.id
        self.price = room.price
        self.roomCount = room.roomCount
        self.bathCount = room.bathCount
        self.images = room.images
        self.size = room.size
        self.about = room.about
        self.createdAt = room.createdAt
        self.updatedAt = room.updatedAt
        self.owner = room.owner
        self.savedBy = room.savedBy
        self.address = room.address
    }
    
    func update(from room: Room){
        self.id = room.id
        self.price = room.price
        self.roomCount = room.roomCount
        self.bathCount = room.bathCount
        self.images = room.images
        self.size = room.size
        self.about = room.about
        self.createdAt = room.createdAt
        self.updatedAt = room.updatedAt
        self.owner = room.owner
        self.savedBy = room.savedBy
        self.address = room.address
    }
}
