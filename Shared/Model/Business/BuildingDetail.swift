//
//  BuildingDetail.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 09.07.23.
//

import MapKit

struct BuildingDetail: Decodable {
    
    let id: Int
    let name: String
    let yearOfConstruction: String
    let address: String
    let zipCode: String
    let city: String
    let country: String
    let cityCountry: String
    let latitude: Double
    let longitude: Double
    let feedImageURL: URL?
    let galleryImages: [URL]
    let subtitle: String
    let todaysUse: String
    let description: String
    let history: String
    let architects: [Architect]
    let absoluteURL: URL
    let buildingType: String
    
    let attributedDescription: AttributedString
    let attributedHistory: AttributedString
}

extension BuildingDetail: MapItemProtocol {
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
