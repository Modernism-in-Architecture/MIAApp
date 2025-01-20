//
//  UserDefaults.swift
//  MIACore
//
//  Created by Sören Kirchner (privat) on 30.12.24.
//

import Foundation

public extension UserDefaults {
    
    static var lastBuildingsFetchSuccess: Date? {
        
        get {
            return UserDefaults.standard.object(forKey: "lastBuildingsFetchSuccess") as? Date
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "lastBuildingsFetchSuccess")
        }
    }
}
