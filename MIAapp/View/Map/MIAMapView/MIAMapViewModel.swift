//
//  MIAMapViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 06.11.24.
//

import SwiftUI
import MapKit
import MIACore

class MIAMapViewModel: ObservableObject {
    
    @Published
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .leipzig)
    
//    func setCameraPosition(to location: CLLocationCoordinate2D) {
//        cameraPosition = .camera(.init(centerCoordinate: location, distance: .defaultCameraDistance))
//    }
    
    func setCameraPosition(to mapItem: MapItemProtocol) {
        cameraPosition = .camera(.init(centerCoordinate: mapItem.coordinate, distance: .defaultCameraDistance))
    }
}
