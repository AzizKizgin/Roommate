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

struct RoomUpsertInfo: Encodable {
    var price: Double
    var roomCount: Int
    var bathCount: Int
    var images: [String]
    var size: Double
    var about: String
    var address: RoomAddress
}

struct RoomAddress: Codable {
    var street: String
    var city: String
    var town: String
    var country: String
    var buldingNo: String
    var apartmentNo: String
    var zipCode: String
    var latitude: Double
    var longitude: Double
}
