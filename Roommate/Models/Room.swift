//
//  Room.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

struct Room: Identifiable, Decodable {
    let id: Int
    let price: Double
    let roomCount: Int
    let bathCount: Int
    let images: [String]
    let size: Double
    let description: String
    let createdAt: String
    let updatedAt: String?
    let owner: RoomUser
    let savedBy: [RoomUser]
    let address: RoomAddress
}

struct RoomUpsertInfo: Encodable {
    var price: Double
    var roomCount: Int
    var bathCount: Int
    var images: [String]
    var size: Double
    var description: String
    var address: RoomAddress
}

struct RoomAddress: Codable {
    let street: String
    let city: String
    let state: String
    let zipCode: String
    let latitude: Double
    let longitude: Double
}
