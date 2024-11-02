//
//  BuildingDetailMapView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 24.10.21.
//

import SwiftUI
import MapKit
import OSLog

struct BuildingDetailMapView: View {
    
    @State var building: Building
    
    var body: some View {
        
        let cameraPosition: MapCameraPosition = .camera(
            MapCamera(centerCoordinate: building.coordinate, distance: 1000)
        )
        
        Map(initialPosition: cameraPosition) {
            
            Annotation(
                building.name,
                coordinate: building.coordinate
            ) {
                MIAMapPinView(building: building)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    BuildingDetailMapView(building: .schunckMock)
}
