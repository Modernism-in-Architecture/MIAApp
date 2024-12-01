//
//  BuildingsListSuccessView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.05.22.
//

import SwiftUI

struct BuildingsListSuccessView: View {
    
    @EnvironmentObject
    var router: MIARouter
    
    @State private var searchText = ""
    @State var buildings: [Building]
    @State private var isSearching = false
    let columns = [GridItem(.adaptive(minimum: 300, maximum: 400))]
    
    var body: some View {
        
        @ObservedObject
        var router = self.router
        
//        NavigationStack(path: $router.path) {
            
            VStack {
                
                if isSearching {
                    MIASearchBar(text: $searchText, isSearching: $isSearching)
                }
                
                ScrollView {
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                        
                        ForEach(searchResults) { building in
                            
                            BuildingsListCellView(building: building, searchText: searchText)
                                .onTapGesture {
                                    router.showBuildingDetail(building: building)
                                }
                            
//                            NavigationLink(value: MIARouter.BuildingRoute.detail(building: building)) {
//                                BuildingsListCellView(building: building, searchText: searchText)
//                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .padding()
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Buildings")
                .navigationViewStyle(StackNavigationViewStyle())
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        MIAToolBarLogo()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        MIASearchButton(isSearching: $isSearching)
                    }
                }
//            }
//            .navigationDestination(for: MIARouter.BuildingRoute.self) { buildingRoute in
//                
//                if case let .detail(building) = buildingRoute {
//                    BuildingDetailView(building: building)
//                }
//                
//            }
        }
//        .disableAutocorrection(true)
//        .searchable(text: $searchText)
    }
    
    var searchResults: [Building] {
        
        if searchText.isEmpty {
            return buildings
        }
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return buildings.filter { building in
            
            building.name.lowercased().contains(trimmed) ||
                building.city.lowercased().contains(trimmed) ||
                building.country.lowercased().contains(trimmed)
        }
    }
}

// struct BuildingsListSuccessView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingsListSuccessView()
//    }
// }
