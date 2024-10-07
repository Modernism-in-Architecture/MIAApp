//
//  Logger.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 28.12.23.
//

import OSLog

// MARK: - Loggers

extension Logger {
    
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let cache = Logger(category: "cache")
    static let buildingDetail = Logger(category: "buildingDetail")
    static let buildingsManager = Logger(category: "buildingsManager")
    static let client = Logger(category: "client")
    static let general = Logger(category: "general")
    static let router = Logger(category: "router")
    static let map = Logger(category: "map")
}

// MARK: - Convenience Init

extension Logger {
    
    init(category: String) {
        self.init(subsystem: Self.subsystem, category: category)
    }
}
