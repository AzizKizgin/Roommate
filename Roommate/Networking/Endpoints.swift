//
//  Endpoints.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

enum Endpoints {
    private static let baseURL = "http://localhost:5031/api"
    private static let roomURL = "\(baseURL)/room"
    private static let userURL = "\(baseURL)/user"
    
    // MARK: - Book URLs
    public static func getAddRoomURL() -> URL{
        return URL(string: roomURL)!
    }
    
    public static func getRoomListURL(query: RoomQueryObject?) -> URL {
        let urlString = "\(roomURL)?query=\(query?.toJSONString() ?? "")"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getRoomURL(id: Int) -> URL {
        let urlString = "\(roomURL)/\(id)"
        let url = URL(string: urlString)!
        return url
    }
    
    // MARK: - User URLs
    
    public static func getRegisterURL() -> URL {
        let urlString = "\(userURL)/register"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getLoginURL() -> URL {
        let urlString = "\(userURL)/login"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getLogoutURL() -> URL {
        let urlString = "\(userURL)/logout"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getUserURL(id: String) -> URL {
        let urlString = "\(userURL)/\(id)"
        let url = URL(string: urlString)!
        return url
    }

    public static func getUserRoomsURL(id: String) -> URL {
        let urlString = "\(userURL)/\(id)/rooms"
        let url = URL(string: urlString)!
        return url
    }

    public static func getUserSavedRoomsURL(id: String) -> URL {
        let urlString = "\(userURL)/\(id)/saved-rooms"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getChangePasswordURL() -> URL {
        let urlString = "\(userURL)/change-password"
        let url = URL(string: urlString)!
        return url
    }
}
