//
//  MapItemProtocol.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 05.12.24.
//

import MapKit

protocol MapItemProtocol {
    
    var id: Int { get }
    var name: String { get }
    var feedImageURL: URL? { get }
    var coordinate: CLLocationCoordinate2D { get }
}
