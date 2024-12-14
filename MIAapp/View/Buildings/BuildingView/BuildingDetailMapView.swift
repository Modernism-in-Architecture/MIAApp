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
    
    @State var mapItem: MapItemProtocol
    
    var body: some View {
        
        let cameraPosition: MapCameraPosition = .camera(
            MapCamera(centerCoordinate: mapItem.coordinate, distance: 1000)
        )
        
        Map(initialPosition: cameraPosition) {
            
            Annotation(
                mapItem.name,
                coordinate: mapItem.coordinate
            ) {
                MIAMapPinView(previewImageURL: mapItem.feedImageURL)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    BuildingDetailMapView(mapItem: BuildingDetail.schunckMock)
}
