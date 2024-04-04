//
//  DataManager.swift
//  Roommate
//
//  Created by Aziz Kızgın on 4.04.2024.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func sendRequest<T: Decodable>(
        for url: URL,
        data: Data? = nil,
        requestType: RequestType,
        completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
            
        if let data{
            request.httpBody = data
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                let dataError = NSError(domain: "Roommate", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(dataError))
                return
            }
    
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch let decoderError {
                completion(.failure(decoderError))
            }
         
        }.resume()
    }


}
