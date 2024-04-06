//
//  UserProtocol.swift
//  Roommate
//
//  Created by Aziz Kızgın on 5.04.2024.
//

import Foundation

protocol UserProtocol {
    var id: String { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var profilePicture: String? { get set }
    var createdAt: Date { get set }
    var about: String { get set }
    var birthDate: Date { get set }
    var job: String { get set }
    var phoneNumber: String { get set }
    var email: String { get set }
}
