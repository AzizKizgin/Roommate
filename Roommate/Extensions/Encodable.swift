//
//  Encodable.swift
//  Roommate
//
//  Created by Aziz Kızgın on 9.04.2024.
//

import Foundation

extension Encodable {
    func toData() -> Data?{
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        }
        catch {
            return nil
        }
    }
    
    func toJSONString() -> String {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)!
        }
        catch {
            return ""
        }
    }
}
