//
//  MapHomeView.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 02.11.24.
//

import SwiftUI

struct MapHomeView: View {
    
    @EnvironmentObject
    var router: MIARouter
    
    var body: some View {
        
        NavigationStack(path: $router.path.animation(.easeInOut)) {
            
            MIAMapView()
                .navigationDestination(for: MIARouter.DetailsRoute.self) { destination in
                    destination.view
                }
        }
    }
}

#Preview {
    MapHomeView()
}
