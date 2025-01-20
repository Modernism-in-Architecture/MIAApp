//
//  BuildingsListViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 04.01.25.
//

import CoreLocation
import SwiftUI
import MIACore
import MIACoreNetworking

// MARK: - BuildingsListViewModel

class BuildingsListViewModel: ObservableObject {
        
    @Published
    var state: LoadingState = .loading
    
    @Published
    var buildings: [Building] = []
    
    private var buildingsMangager = BuildingsManager()
}

extension BuildingsListViewModel {
    
    func fetch() {
        
        state = .loading
        
        Task {
            await fetch()
        }
    }
}

@MainActor
extension BuildingsListViewModel {
    
    func refresh() async {
        await fetch()
    }
}

// MARK: - Load Buildings

@MainActor
private extension BuildingsListViewModel {
    
    func fetch() async {
        
        do {
            
            let buildings = try await buildingsMangager.getBuildings()
            self.handle(buildings: buildings)
        } catch {
            self.handleLoadError(error: error)
        }
    }
    
    private func handle(buildings: [Building]) {
        
        self.buildings = buildings
        self.state = .success
    }
    
    private func handleLoadError(error: Error) {
        // TODO: Handle correct Manager error
        self.state = .error(.NetworkError)
    }
}

extension BuildingsListViewModel {
    
    func fetchBuildingFor(id: Int) async throws -> BuildingDetail {
        try await buildingsMangager.getBuildingDetail(for: id)
    }
}
