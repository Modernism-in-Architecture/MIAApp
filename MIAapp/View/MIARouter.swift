//
//  Router.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 19.05.24.
//

import SwiftUI

class MIARouter: ObservableObject {
    
    @Published
    var path = NavigationPath()
    
    @Published
    var selectedTab: MainScreen = .buildings
    
//    @Published
//    var buildingRoutes: [BuildingRoute] = []
    
//    var mapRoutes: [MapRoute] = []
    
//    @Published
//    var architectRoutes: [ArchitectRoute] = []
    
//    var bookmarksRoutes: [BookmarksRoute] = []
    
    enum MainScreen: Identifiable, Hashable, CaseIterable {
        
        case buildings
        case map
        case architects
        case bookmarks
        
        var id: MainScreen {
            self
        }
    }
    
    enum DetailsRoute: Hashable {
        
        case architect(architect: Architect)
        case building(building: Building)
        
        @ViewBuilder
        var view: some View {
            
            switch self {
            case let .architect(architect):
                ArchitectDetailView(id: architect.id)
                
            case let .building(building):
                BuildingView(building: building)
            }
        }
    }
//    
//    enum BuildingRoute: Hashable {
//        
//        case home
//        case detail(building: Building)
//    }
//    
//    enum MapRoute {
//        case home(building: BuildingRoute?)
//    }
//    
//    enum ArchitectRoute: Hashable {
//        
//        case home
//        case detail(architect: Architect)
//    }
//    
//    enum BookmarksRoute {
//        case home
//    }
}

@MainActor
extension MIARouter {
    
    func showBuildingDetail(building: Building) {
        path.append(DetailsRoute.building(building: building))
    }
    
    func showArchitectDetail(architect: Architect) {
        path.append(DetailsRoute.architect(architect: architect))
    }
}

// MARK: - Root Views

extension MIARouter.MainScreen {
    
    @ViewBuilder
    var rootView: some View {
        
        switch self {
        case.buildings:
            BuildingsHomeView()
            
        case .map:
            MIAMapView()
            
        case .architects:
            ArchitectsHomeView()
            
        case .bookmarks:
            BookmarksView()
        }
    }
}

// MARK: - Labels

extension MIARouter.MainScreen {
    
    @ViewBuilder
    var label: some View {
        
        switch self {
        case .buildings:
            Label("Buildings", systemImage: "building.2")
            
        case .map:
            Label("Places", systemImage: "map")
            
        case .architects:
            Label("Architects", systemImage: "person.2")
            
        case .bookmarks:
            Label("Bookmarks", systemImage: "bookmark")
        }
    }
}
