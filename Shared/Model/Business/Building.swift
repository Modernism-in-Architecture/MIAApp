//
//  MIAData.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import Foundation
import MapKit

struct Building: Identifiable {

    let id: Int
    let name: String
    let yearOfConstruction: String
    let city: String
    let country: String
    let feedImage: URL?
    let previewImage: URL?
    let coordinate: CLLocationCoordinate2D
}

extension Building: Hashable {
    
    static func == (lhs: Building, rhs: Building) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Building empty

extension Building {
    
    static let empty = Building(
        id: 0,
        name: "",
        yearOfConstruction: "",
        city: "",
        country: "",
        feedImage: URL(string: "https://modernism-in-architecture.org"),
        previewImage: URL(string: "https://modernism-in-architecture.org"),
        coordinate: CLLocationCoordinate2D(
            latitude: CLLocation.leipzig.coordinate.latitude,
            longitude: CLLocation.leipzig.coordinate.longitude
        )
    )
}
