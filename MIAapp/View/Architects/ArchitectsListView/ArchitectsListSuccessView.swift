//
//  ArchitectListSuccessView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 31.05.22.
//

import SwiftUI

struct ArchitectsListSuccessView: View {
    
    @EnvironmentObject
    var router: MIARouter
    
    @EnvironmentObject
    var architectsListViewModel: ArchitectsListViewModel
    
    @State private var searchText = ""
    @State private var isSearching = false
    @State var isKeyboardShowing = false

    var body: some View {
        
        @ObservedObject
        var router = self.router
                    
        let groupedArchitects = groupedArchitects
            
        VStack {
                
            if isSearching {
                MIASearchBar(text: $searchText, isSearching: $isSearching)
            }
                
            ScrollViewReader { proxy in
                    
                ZStack {
                        
                    List {
                            
                        ForEach(groupedArchitects.keys.sorted(), id: \.self) { key in
                                
                            Section(header: Text("\(key)")) {
                                    
                                if let architects = groupedArchitects[key] {
                                        
                                    ForEach(architects) { architect in
                                            
//                                        NavigationLink(value: MIARouter.ArchitectRoute.detail(architect: architect)) {
//                                            Text("\(architect.fullName)")
//                                        }
                                        Text("\(architect.fullName)")
                                            .onTapGesture {
                                                router.showArchitectDetail(architect: architect)
                                            }
                                    }
                                }
                            }
                        }
                    }
                    .disableAutocorrection(true)
                    .listStyle(.insetGrouped)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                            
                        ToolbarItem(placement: .navigationBarLeading) {
                            MIAToolBarLogo()
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            MIASearchButton(isSearching: $isSearching)
                        }
                    }
                    if !isSearching {
                        MIASectionIndexView(scrollViewProxy: proxy, keys: groupedArchitects.keys.sorted())
                    }
                }
                .onAppear {
                        
                    if let firstIndex = groupedArchitects.keys.sorted().first {
                        proxy.scrollTo(firstIndex, anchor: .top)
                    }
                }
                .navigationTitle("Architects")
            }
        }
    }
    
    var searchResults: [Architect] {
        
        if searchText.isEmpty {
            return architectsListViewModel.architects
        }
        return architectsListViewModel.architects.filter { architect in
            
            architect.firstName.lowercased().contains(searchText.lowercased()) ||
                architect.lastName.lowercased().contains(searchText.lowercased())
        }
    }
    
    var groupedArchitects: [String: [Architect]] {
        
        Dictionary(grouping: searchResults, by: { architect in
            
            let normalizedName = architect.lastName.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            return String(normalizedName.first!).uppercased()
        })
    }
}

// struct ArchitectListSuccessView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchitectListSuccessView()
//    }
// }
