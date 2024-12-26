//
//  APIArchitect.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 10.07.23.
//

import Foundation

// MARK: - APIWelcome

public struct APIArchitects: Decodable {
    let data: [APIArchitect]
}

extension APIArchitects {
    
    // MARK: - APIArchitect
    
    public struct APIArchitect: Decodable {
        
        let id: Int
        let lastName: String
        let firstName: String
    }
}
