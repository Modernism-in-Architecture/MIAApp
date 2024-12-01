//
//  MIAMapViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 06.11.24.
//

import SwiftUI
import MapKit

class MIAMapViewModel: ObservableObject {
    
    @Published
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .leipzig)
    
//    func setCameraPosition(to location: CLLocationCoordinate2D) {
//        cameraPosition = .camera(.init(centerCoordinate: location, distance: .defaultCameraDistance))
//    }
    
    func setCameraPosition(to building: Building) {
        cameraPosition = .camera(.init(centerCoordinate: building.coordinate, distance: .defaultCameraDistance))
    }
}
