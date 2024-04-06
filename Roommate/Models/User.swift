//
//  User.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

struct User: Identifiable, Decodable, UserProtocol {
    var id: String
    var firstName: String
    var lastName: String
    var profilePicture: String?
    var rooms: [Room]
    var savedRooms: [Room]
    var createdAt: Date
    var about: String
    var birthDate: Date
    var job: String
    var phoneNumber: String
    var email: String
    var token: String?
}

struct UserUpdateInfo: Encodable {
    let firstName: String
    let lastName: String
    let profilePicture: String?
    let about: String
    var birthDate: Date
    let job: String
}

struct RoomOwner: Decodable, Identifiable {
    let id: String
    let firstName: String
    let lastName: String
    let profilePicture: String?
    let createdAt: Date
    let about: String
    var birthDate: Date
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
    var birthDate: Date
}
