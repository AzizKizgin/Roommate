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
    var createdAt: String
    var about: String
    var birthDate: String
    var job: String
    var phoneNumber: String
    var email: String
    var token: String?
}

struct UserUpdateInfo: Encodable {
    var firstName: String
    var lastName: String
    var profilePicture: String?
    var about: String
    var birthDate: String
    var job: String
    
    init(firstName: String, lastName: String, profilePicture: String? = nil, about: String, birthDate: String, job: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = profilePicture
        self.about = about
        self.birthDate = birthDate
        self.job = job
    }
    
    init(){
        self.firstName = ""
        self.lastName = ""
        self.profilePicture = nil
        self.about = ""
        self.birthDate = Utils.dateToString(date: Utils.get18YearsAgo())
        self.job = ""
    }
}

struct RoomOwner: Decodable, Identifiable {
    let id: String
    let firstName: String
    let lastName: String
    let profilePicture: String?
    let createdAt: String
    let about: String
    var birthDate: String
    let job: String
}

struct UserLoginInfo: Encodable {
    var email: String
    var password: String
}

struct UserRegisterInfo: Encodable {
    var id = UUID()
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var job: String
    var birthDate: String
    
    init(id: UUID = UUID(), email: String, password: String, firstName: String, lastName: String, phoneNumber: String, job: String, birthDate: String) {
        self.id = id
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.job = job
        self.birthDate = birthDate
    }
    
    init() {
        self.email = ""
        self.password = ""
        self.firstName = ""
        self.lastName = ""
        self.phoneNumber = ""
        self.job = ""
        self.birthDate = "01.01.2006"
    }
    
}
