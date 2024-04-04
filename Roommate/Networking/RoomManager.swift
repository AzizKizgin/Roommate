//
//  RoomManager.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

class RoomManager {
    
    static let shared = RoomManager()
    
    private init() {}

    func getRooms(query: RoomQueryObject,completion: @escaping (Result<[Room],Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getRoomListURL(query: query),
            requestType: .get){(result: Result<[Room],Error>) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func getRoom(id: Int, completion: @escaping (Result<Room,Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getRoomURL(id: id),
            requestType: .get){(result: Result<Room,Error>) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func createRoom(roomData: RoomUpsertInfo, completion: @escaping (Result<Room,Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getAddRoomURL(),
            data: roomData.toData(),
            requestType: .post){(result: Result<Room,Error>) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func updateRoom(id: Int, roomData: RoomUpsertInfo, completion: @escaping (Result<Room,Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getRoomURL(id: id),
            data: roomData.toData(),
            requestType: .put){(result: Result<Room,Error>) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func deleteRoom(id: Int, completion: @escaping (Result<Room,Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getRoomURL(id: id),
            requestType: .delete){(result: Result<Room,Error>) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func favoriteRoom(id: Int, completion: @escaping (Result<Room,Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getRoomURL(id: id),
            requestType: .post){(result: Result<Room,Error>) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
