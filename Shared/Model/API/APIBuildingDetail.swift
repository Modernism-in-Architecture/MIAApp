//
//  APIBuildingDetail.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 09.07.23.
//

import Foundation

// MARK: - APIBuildingDetail

struct APIBuildingDetail: Decodable {
    let data: APIData
}

extension APIBuildingDetail {
    
    // MARK: - APIData
    
    struct APIData: Decodable {
        
        let id: Int
        let name: String
        let yearOfConstruction: String
        let isProtected: Bool
        let address: String
        let zipCode: String
        let city: String
        let country: String
        let latitude: Double
        let longitude: Double
        let galleryImages: [String]
        let subtitle: String
        let todaysUse: String
        let buildingType: String
        let history: String
        let historyMarkdown: String
        let description: String
        let descriptionMarkdown: String
        let directions: String
        let architects: [APIArchitect]
        let absoluteURL: String
    }
    
    // MARK: - APIArchitect
    
    struct APIArchitect: Decodable {
        
        let id: Int
        let lastName: String
        let firstName: String
    }
}
