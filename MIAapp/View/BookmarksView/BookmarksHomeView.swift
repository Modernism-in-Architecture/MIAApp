//
//  BookmarksHomeView.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 08.11.24.
//

import SwiftUI

struct BookmarksHomeView: View {
    
    @EnvironmentObject
    var router: MIARouter
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            
            BookmarksView()
                .navigationDestination(for: MIARouter.DetailsRoute.self) { destination in
                    destination.view
                }
        }
    }
}

#Preview {
    BookmarksHomeView()
}
