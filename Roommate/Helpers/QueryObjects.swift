//
//  QueryObjects.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

struct RoomQueryObject: Encodable, Equatable {
    var minPrice: Double?
    var maxPrice: Double?
    var roomCounts: [Int]?
    var bathCounts: [Int]?
    var minSize: Double?
    var maxSize: Double?
    var page: Int = 1
    var pageSize: Int = 15
    var street: String?
    var city: String?
    var town: String?
    var latitude: Double?
    var longitude: Double?
    var distance: Double?
    var sortBy: SortByProperty?
    var sortDirection: SortDirection?
    var dateRange: DateRange?
    
    func toQueryItems() -> [URLQueryItem] {
        let mirror = Mirror(reflecting: self)
        var queryItems = [URLQueryItem]()
        
        for case let (label?, value) in mirror.children {
            if label == "bathCounts" {
                if let arrayValue = value as? [CustomStringConvertible] {
                         for element in arrayValue {
                             queryItems.append(URLQueryItem(name: "\(label)", value: element.description))
                         }
                     } 
            }
            else if label == "roomCounts" {
                if let arrayValue = value as? [CustomStringConvertible] {
                         for element in arrayValue {
                             queryItems.append(URLQueryItem(name: "\(label)", value: element.description))
                         }
                     }
            }
            else if let stringValue = value as? CustomStringConvertible {
                let stringRepresentation = stringValue.description
                queryItems.append(URLQueryItem(name: label, value: stringRepresentation))
            }
        }
        print(queryItems)
        return queryItems
    }
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
