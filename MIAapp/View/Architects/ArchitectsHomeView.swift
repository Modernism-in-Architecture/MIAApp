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
                    destination.view
                }
        }
    }
}

#Preview {
    ArchitectsHomeView()
}
