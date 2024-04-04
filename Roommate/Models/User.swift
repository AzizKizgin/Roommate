//
//  User.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let profilePicture: String?
    let rooms: [Room]
    let savedRooms: [Room]
    let createdAt: Date
    let description: String
    let age: Int
    let job: String
}

struct UserUpdateInfo: Encodable {
    let firstName: String
    let lastName: String
    let profilePicture: String?
    let description: String
    let age: Int
    let job: String
}

struct RoomOwner: Decodable, Identifiable {
    let id: String
    let firstName: String
    let lastName: String
    let profilePicture: String?
    let createdAt: Date
    let description: String
    let age: Int
    let job: String
}

struct UserLoginInfo: Encodable {
    var email: String
    var password: String
}

struct UserRegisterInfo: Encodable {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var job: String
    var age: Int
}
