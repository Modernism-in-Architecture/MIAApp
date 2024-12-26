//
//  Constants.swift
//  MIANetworking
//
//  Created by Sören Kirchner (privat) on 23.12.24.
//

import Foundation

enum MIADefaults {
    
    enum ImageCache {
        
        static let maxAge: TimeInterval = 24 * 60 * 60 // one day
        static let countLimit = 50
        static let totalCostLimit = 250 * 1024 * 1024 // 0.25 GB
    }
}

enum Secrets {
    
    static let api_token = Bundle.main.infoDictionary?["API_TOKEN"] as? String ?? ""
}
