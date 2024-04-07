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
    var createdAt: String
    var about: String
    var birthDate: String
    var job: String
    var phoneNumber: String
    var email: String
    var token: String
    
    init(id: String, firstName: String, lastName: String, profilePicture: String? = nil, createdAt: String, about: String, birthDate: String, job: String, phoneNumber: String, email: String, token: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = profilePicture
        self.createdAt = createdAt
        self.about = about
        self.birthDate = birthDate
        self.job = job
        self.phoneNumber = phoneNumber
        self.email = email
        self.token = token
    }
}
