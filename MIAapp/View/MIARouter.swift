//
//  Router.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 19.05.24.
//

import SwiftUI
import Combine
import OSLog

class MIARouter: ObservableObject {
    
    @Published
    var path = NavigationPath()
    
    @Published
    var selectedTab: MainScreen = .buildings
    
    @Published
    private(set) var tabBarVisibility: Visibility = .visible
    
    private(set) var selectedBuildingForMap: Building = .empty
        
    private var subscribers = Set<AnyCancellable>()
    
    init() {
        setup()
    }
    
    func setup() {
        
        self.$path.sink { newPath in
            
            if newPath.isEmpty {
                self.showTabbar()
            }
        }
        .store(in: &subscribers)
    }
        
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
                BuildingDetailView(building: building)
            }
        }
    }
}

private extension MIARouter {
    
    func showTabbar() {
        
        withAnimation{
            self.tabBarVisibility = .visible
        }
    }
        
    func hideTabbar() {
        self.tabBarVisibility = .hidden
    }
}

//@MainActor
extension MIARouter {
    
    func toRoot() {
        
        showTabbar()
        while path.count > 0 {
            path.removeLast()
        }
    }
    
    func showBuildingDetail(building: Building) {
        
        hideTabbar()
        path.append(DetailsRoute.building(building: building))
    }
    
    func showArchitectDetail(architect: Architect) {
        
        hideTabbar()
        path.append(DetailsRoute.architect(architect: architect))
    }
    
    func showMap(with building: Building) {
        
        toRoot()
        selectedBuildingForMap = building
        selectedTab = .map
    }
    
    func switchToBuildingsAndShowDetail(for building: Building) {
        
        selectedTab = .buildings
        showBuildingDetail(building: building)
    }
}

// MARK: - Root Views

extension MIARouter.MainScreen {
    
    @ViewBuilder
    var rootView: some View {
        
        switch self {
        case .buildings:
            BuildingsHomeView()
            
        case .map:
            MapHomeView()
            
        case .architects:
            ArchitectsHomeView()
            
        case .bookmarks:
            BookmarksHomeView()
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
