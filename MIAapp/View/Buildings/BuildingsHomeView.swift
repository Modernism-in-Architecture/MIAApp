//
//  BuildingsHomeView.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 01.11.24.
//

import SwiftUI

struct BuildingsHomeView: View {
    
    @EnvironmentObject
    var router: MIARouter
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            
            BuildingsListView()
                .navigationDestination(for: MIARouter.DetailsRoute.self) { destination in
                    
                    destination.view
                        .toolbar(.hidden, for: .tabBar)
                }
        }
    }
}

#Preview {
    BuildingsHomeView()
}
