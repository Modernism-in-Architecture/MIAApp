//
//  Logger.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 28.12.23.
//

import OSLog

// MARK: - Loggers

extension Logger {
    
    private static let subsystem = Bundle.main.bundleIdentifier!
    
    public static let cache = Logger(category: "cache")
    public static let buildingDetail = Logger(category: "buildingDetail")
    public static let buildingsManager = Logger(category: "buildingsManager")
    public static let client = Logger(category: "client")
    public static let general = Logger(category: "general")
    public static let router = Logger(category: "router")
    public static let map = Logger(category: "map")
}

// MARK: - Convenience Init

extension Logger {
    
    init(category: String) {
        self.init(subsystem: Self.subsystem, category: category)
    }
}
