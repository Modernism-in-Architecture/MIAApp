//
//  Date+Extensions.swift
//  MIACore
//
//  Created by Sören Kirchner (privat) on 30.12.24.
//

import Foundation

extension Date {
    
    public func toISO8601String() -> String {
        
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: self)
    }
}
