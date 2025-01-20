//
//  Constants.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 06.01.25.
//

import Foundation

enum Secrets {
    
    static let api_token = Bundle.main.infoDictionary?["API_TOKEN"] as? String ?? ""
}
