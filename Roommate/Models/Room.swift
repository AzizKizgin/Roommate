//
//  Room.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

struct Room: Identifiable, Decodable, RoomProtocol {
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
}

struct RoomsResponse: Decodable {
    let rooms: [Room]
    let totalCount: Int
    let page: Int
    let pageSize: Int
}

struct RoomUpsertInfo: Encodable {
    var id: Int?
    var price: String
    var roomCount: String
    var bathCount: String
    var images: [String]
    var size: String
    var about: String
    var address: RoomAddress
    
    init(id: Int? = nil, price: String, roomCount: String, bathCount: String, images: [String], size: String, about: String, address: RoomAddress) {
        self.id = nil
        self.price = price
        self.roomCount = roomCount
        self.bathCount = bathCount
        self.images = images
        self.size = size
        self.about = about
        self.address = address
    }
    
    init(from room: Room) {
        self.id = room.id
        self.price = String(room.price)
        self.roomCount = String(room.roomCount)
        self.bathCount = String(room.bathCount)
        self.images = room.images
        self.size = String(room.size)
        self.about = room.about
        self.address = room.address
    }
    
    init () {
        self.id = nil
        self.price = ""
        self.roomCount = ""
        self.bathCount = ""
        self.images = []
        self.size = ""
        self.about = ""
        self.address = RoomAddress()
    }
}

struct RoomAddress: Codable {
    var street: String
    var city: String
    var town: String
    var country: String
    var buildingNo: String
    var apartmentNo: String
    var zipCode: String
    var latitude: Double
    var longitude: Double
    
    init(street: String, city: String, town: String, country: String, buildingNo: String, apartmentNo: String, zipCode: String, latitude: Double, longitude: Double) {
        self.street = street
        self.city = city
        self.town = town
        self.country = country
        self.buildingNo = buildingNo
        self.apartmentNo = apartmentNo
        self.zipCode = zipCode
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init () {
        self.street = ""
        self.city = ""
        self.town = ""
        self.country = ""
        self.buildingNo = ""
        self.apartmentNo = ""
        self.zipCode = ""
        self.latitude = 0.0
        self.longitude = 0.0
    }
}
