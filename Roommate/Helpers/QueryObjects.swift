//
//  QueryObjects.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

struct RoomQueryObject: Encodable {
    var minPrice: Int?
    var maxPrice: Int?
    var minRoomCount: Int?
    var maxRoomCount: Int?
    var minBathCount: Int?
    var maxBathCount: Int?
    var minSize: Double?
    var maxSize: Double?
    var page: Int = 1
    var pageSize: Int = 15
    var street: String?
    var city: String?
    var state: String?
    var latitude: Double?
    var longitude: Double?
    var distance: Double?
    var sortBy: SortByProperty?
    var sortDirection: SortDirection = .asc
    var dateRange: DateRange?
}

enum SortByProperty: Encodable {
    case price
    case roomCount
    case bathCount
    case size
}

enum SortDirection: Encodable {
    case asc
    case desc
}

enum DateRange: Encodable {
    case today
    case thisWeek
    case thisMonth
    case thisYear
}
