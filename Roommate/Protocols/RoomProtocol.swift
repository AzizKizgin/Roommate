//
//  RoomProtocol.swift
//  Roommate
//
//  Created by Aziz Kızgın on 10.04.2024.
//

import Foundation
protocol RoomProtocol {
    var id: Int { get set }
    var price: Double { get set }
    var roomCount: Int { get set }
    var bathCount: Int { get set }
    var images: [String] { get set }
    var size: Double { get set }
    var about: String { get set }
    var createdAt: String { get set }
    var updatedAt: String? { get set }
    var owner: RoomUser { get set }
    var savedBy: [RoomUser] { get set }
    var address: RoomAddress { get set }
}
