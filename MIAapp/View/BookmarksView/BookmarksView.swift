//
//  BookmarksView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 27.06.22.
//

import SwiftUI

// MARK: - BookmarksView

struct BookmarksView: View {
    
    @EnvironmentObject
    var router: MIARouter
    
    @EnvironmentObject
    var buildingsController: BuildingsListViewModel
    
    @EnvironmentObject
    var cloudKitBookmarksController: BookmarksViewModel
    
    var body: some View {
            
        VStack {

            List {
                    
                ForEach(bookmarkedBuildings) { building in
                        
                    VStack(alignment: .leading) {
                        
                        Text(building.name)
                            .lineLimit(1)
                        Text("\(building.city), \(building.country)")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    .onTapGesture {
                        router.showBuildingDetail(building: building)
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(.grouped)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Bookmarks")
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    MIAToolBarLogo()
                }
            }
            .refreshable {
                cloudKitBookmarksController.fetch()
            }
        }
    }
    
    func delete(at indexes: IndexSet) {
        
        if let index = indexes.first {
            cloudKitBookmarksController.toggle(id: bookmarkedBuildings[index].id)
        }
    }
    
    var bookmarkedBuildings: [Building] {
        
        buildingsController.buildings.filter { building in
            cloudKitBookmarksController.contains(id: building.id)
        }
    }
}

// MARK: - BookmarksView_Previews

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksView()
    }
}
