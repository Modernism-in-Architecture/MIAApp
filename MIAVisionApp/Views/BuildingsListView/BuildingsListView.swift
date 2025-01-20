//
//  BuildingsListView.swift
//  MIAVisionApp
//
//  Created by Sören Kirchner (privat) on 04.01.25.
//

import SwiftUI
import MIACore
import MIACoreUI

struct BuildingsListView: View {
    
    @EnvironmentObject
    var buildingsListViewModel: BuildingsListViewModel
    
    private let gridItems: [GridItem] = [.init(.adaptive(minimum: 260), spacing: 16)]
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                
                LazyVGrid(columns: gridItems) {
                    
                    ForEach(buildingsListViewModel.buildings) { building in
                        
                        BuildingsListCardView(imageUrl: building.feedImage, title: building.name, subtitle: building.city)
//                        MIAAsyncHeaderImage(url: building.feedImage, background: .clear)
                        
                    }
                }
                .padding()
            }
        }
        .task {
            buildingsListViewModel.fetch()
        }
    }
}

#Preview {
    BuildingsListView()
        .environmentObject(BuildingsListViewModel())
}
