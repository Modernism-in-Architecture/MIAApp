//
//  MIAData.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import Foundation
import MapKit

public struct Building: Identifiable, Sendable {
    
    public init(
        id: Int,
        name: String,
        yearOfConstruction: String,
        city: String,
        country: String,
        feedImage: URL?,
        previewImage: URL?,
        coordinate: CLLocationCoordinate2D
    ) {
        
        self.id = id
        self.name = name
        self.yearOfConstruction = yearOfConstruction
        self.city = city
        self.country = country
        self.feedImage = feedImage
        self.previewImage = previewImage
        self.coordinate = coordinate
    }

    public let id: Int
    public let name: String
    public let yearOfConstruction: String
    public let city: String
    public let country: String
    public let feedImage: URL?
    public let previewImage: URL?
    public let coordinate: CLLocationCoordinate2D
}

extension Building: Hashable {
    
    public static func == (lhs: Building, rhs: Building) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
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
