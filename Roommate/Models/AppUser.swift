//
//  AppUser.swift
//  Roommate
//
//  Created by Aziz Kızgın on 5.04.2024.
//

import Foundation
import SwiftData

@Model
class AppUser: UserProtocol {
    var id: String
    var firstName: String
    var lastName: String
    var profilePicture: String?
    var rooms: [Room]
    var savedRooms: [Room]
    var createdAt: Date
    var about: String
    var age: Int
    var job: String
    var phoneNumber: String
    var email: String
    var token: String
    
    init(id: String, firstName: String, lastName: String, profilePicture: String? = nil, rooms: [Room], savedRooms: [Room], createdAt: Date, about: String, age: Int, job: String, phoneNumber: String, email: String, token: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = profilePicture
        self.rooms = rooms
        self.savedRooms = savedRooms
        self.createdAt = createdAt
        self.about = about
        self.age = age
        self.job = job
        self.phoneNumber = phoneNumber
        self.email = email
        self.token = token
    }
}
