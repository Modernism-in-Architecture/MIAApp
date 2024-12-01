//
//  MIAMapView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 18.10.21.
//

import MapKit
import OSLog
import SwiftUI

// MARK: - MIAMapView

struct MIAMapView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject
    private var buildingsViewModel: BuildingsListViewModel

    @EnvironmentObject
    private var mapViewModel: MIAMapViewModel
    
    @EnvironmentObject
    private var router: MIARouter
    
    @State
    private var showPinShadow = true
    
    @Namespace
    private var mapScope
    
    var body: some View {
                    
        content
    }
    
    var content: some View {
        
        ZStack {
            map
        }
        .mapScope(mapScope)
        .toolbar {
                
            ToolbarItem(placement: .navigationBarLeading) {
                MIAToolBarLogo()
            }
        }
    }
    
    var map: some View {
        
        Map(
            position: $mapViewModel.cameraPosition,
            bounds: MapCameraBounds(minimumDistance: .defaultCameraDistance),
            scope: mapScope
        ) {
            
            UserAnnotation()
            ForEach(buildingsViewModel.buildings) { building in
                
                Annotation(building.name, coordinate: building.coordinate) {
                    
                    MIAMapPinView(building: building, showShadow: showPinShadow)
                    
                        .onTapGesture {
                            
                            Logger.map.debug("Building \(building.id) selected.")
                            router.showBuildingDetail(building: building)
                        }
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .ignoresSafeArea(edges: .bottom)
        .mapControls {

            VStack {
                
                MapPitchToggle()
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            .background(.brown)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Places")
        .onMapCameraChange(frequency: .continuous) { context in
            
            self.showPinShadow = context.camera.distance < .shadowDistanceLimit
            Logger.map.debug("Update Map \(context.camera.distance)")
        }
    }
}

#Preview {
    
    MIAMapView()
        .environmentObject(BuildingsListViewModel())
        .environmentObject(TabController())
}
