//
//  UserManager.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    private init() {}
    
    func register(registerData: UserRegisterInfo, completion: @escaping (Result<User,Error>) -> Void){
        DataManager.shared.sendRequest(
            for: Endpoints.getRegisterURL(),
            data: registerData.toData(),
            requestType: .post){(result: Result<User,Error>) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func login(loginData: UserLoginInfo, completion: @escaping (Result<User,Error>) -> Void){
        DataManager.shared.sendRequest(
            for: Endpoints.getLoginURL(),
            data: loginData.toData(),
            requestType: .post){(result: Result<User,Error>) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func logout(completion: @escaping (Result<Bool,Error>) -> Void){
        DataManager.shared.sendRequest(
            for: Endpoints.getLogoutURL(),
            requestType: .post){(result: Result<User,Error>) in
                switch result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getUser(id: String, completion: @escaping (Result<User,Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getUserURL(id: id),
            requestType: .get
        ) {(result: Result<User,Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func updateUser(id: String, userInfo: UserUpdateInfo, completion: @escaping (Result<User,Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getUserURL(id: id),
            data: userInfo.toData(),
            requestType: .put
        ) {(result: Result<User,Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteUser(id: String, completion: @escaping (Result<Bool,Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getUserURL(id: id),
            requestType: .delete
        ) {(result: Result<Bool,Error>) in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getUserRooms(userId: String, completion: @escaping (Result<[Room],Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getUserRoomsURL(id: userId),
            requestType: .get
        ) {(result: Result<[Room],Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getUserSavedRooms(userId: String, completion: @escaping (Result<[Room],Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getUserSavedRoomsURL(id: userId),
            requestType: .get
        ) {(result: Result<[Room],Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func changePassword(changePasswordInfo: ChangePasswordInfo, completion: @escaping (Result<User,Error>) -> Void) {
        DataManager.shared.sendRequest(
            for: Endpoints.getChangePasswordURL(),
            data: changePasswordInfo.toData(),
            requestType: .post
        ) {(result: Result<User,Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
