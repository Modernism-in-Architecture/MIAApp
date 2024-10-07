//
//  Router.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 19.05.24.
//

import SwiftUI

class MIARouter: ObservableObject {
    
    @Published
    var selectedTab: MainScreen = .buildings
    
    @Published
    var buildingRoutes: [BuildingRoute] = []
    
    var mapRoutes: [MapRoute] = []
    var architectRoutes: [ArchitectRoute] = []
    var bookmarksRoutes: [BookmarksRoute] = []
    
    enum MainScreen: Identifiable, Hashable, CaseIterable {
        
        case buildings
        case map
        case architects
        case bookmarks
        
        var id: MainScreen {
            self
        }
    }
    
    enum BuildingRoute: Hashable {
        
        case home
        case detail(building: Building)
    }
    
    enum MapRoute {
        case home(building: BuildingRoute?)
    }
    
    enum ArchitectRoute: Hashable {
        
        case home
        case detail(architect: Architect)
    }
    
    enum BookmarksRoute {
        case home
    }
}

@MainActor
extension MIARouter {
    
    func showBuilding(building: Building) {
        
        buildingRoutes.removeAll()
        buildingRoutes.append(.detail(building: building))
        selectedTab = .buildings
    }
    
    func showArchitect(architect: Architect) {
        
        architectRoutes.removeAll()
        architectRoutes.append(.detail(architect: architect))
        selectedTab = .architects
    }
}

// MARK: - Root Views

extension MIARouter.MainScreen {
    
    @ViewBuilder
    var rootView: some View {
        
        switch self {
        case.buildings:
            BuildingsListView()
            
        case .map:
            MIAMapView()
            
        case .architects:
            ArchitectsListView()
            
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
