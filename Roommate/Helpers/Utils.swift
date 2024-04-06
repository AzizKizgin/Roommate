//
//  Utils.swift
//  Roommate
//
//  Created by Aziz Kızgın on 6.04.2024.
//

import Foundation
struct Utils {
    static func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Date String to Date
    static func stringtoDate(dateString: String) -> Date? {
        guard !dateString.isEmpty else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return nil
    }
    
    // MARK: - Getting 18 Years Ago
    static func get18YearsAgo() -> Date{
        let currentDate = Date()
        let calendar = Calendar.current
        
        if let date = calendar.date(byAdding: .year, value: -18, to: currentDate) {
            return date
        } else {
            return .now
        }
    }
    
    // MARK: - Checking Password Validation
    static func isPasswordValid(for password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    // MARK: - Checking Email Validation
    static func isValidEmail(for email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
