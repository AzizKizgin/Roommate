//
//  QueryObjects.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

struct RoomQueryObject: Encodable {
    var minPrice: Double?
    var maxPrice: Double?
    var roomCounts: [Int]?
    var bathCounts: [Int]?
    var minSize: Double?
    var maxSize: Double?
    var page: Int = 1
    var pageSize: Int = 1
    var street: String?
    var city: String?
    var town: String?
    var latitude: Double?
    var longitude: Double?
    var distance: Double?
    var sortBy: SortByProperty?
    var sortDirection: SortDirection?
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
