//
//  ArchitectsHomeView.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 01.11.24.
//

import SwiftUI

struct ArchitectsHomeView: View {
    
    @EnvironmentObject
    var router: MIARouter
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            
            ArchitectsListView()
                .navigationDestination(for: MIARouter.DetailsRoute.self) { destination in
                    
//                    if case let .architect(architect) = destination {
//                        ArchitectDetailView(id: architect.id)
//                            .toolbar(.hidden, for: .tabBar)
//                    }
                    destination.view
                        .toolbar(.hidden, for: .tabBar)
//
//                    switch destination {
//                    case let .architect(architect):
//                        ArchitectDetailView(id: architect.id)
//                            .toolbar(.hidden, for: .tabBar)
//                    case let .building(building):
//                        BuildingView(building: building)
//                            .toolbar(.hidden, for: .tabBar)
//                    }
                }
        }
    }
}

#Preview {
    ArchitectsHomeView()
}
