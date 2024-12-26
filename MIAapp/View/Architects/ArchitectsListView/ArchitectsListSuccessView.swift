//
//  ArchitectListSuccessView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 31.05.22.
//

import SwiftUI
import MIACore

// MARK: - ArchitectsListSuccessView

struct ArchitectsListSuccessView: View {
    
    @EnvironmentObject
    var router: MIARouter
    
    @EnvironmentObject
    var architectsListViewModel: ArchitectsListViewModel
    
    @State private var searchText = ""
    @State private var isSearching = false
    @State var isKeyboardShowing = false

    var body: some View {
        content
    }
}

// MARK: - Views

private extension ArchitectsListSuccessView {
    
    var content: some View {
            
        VStack {
            
            @ObservedObject
            var router = self.router
                        
            if isSearching {
                MIASearchBar(text: $searchText, isSearching: $isSearching)
            }
                
            ArchitectsGroupedListView(
                router: router,
                isSearching: $isSearching,
                groupedArchitects: groupedArchitects
            )
            .toolbar { toolbar }
            .navigationTitle("Architects")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarLeading) {
            MIAToolBarLogo()
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            MIASearchButton(isSearching: $isSearching)
        }
    }
}

// MARK: - Views (structs)

private extension ArchitectsListSuccessView {
    
    struct ArchitectsGroupedListView: View {
        
        @ObservedObject
        var router: MIARouter
        
        @Binding
        var isSearching: Bool

        let groupedArchitects: [String: [Architect]]
        
        var body: some View {
            
            ScrollViewReader { proxy in
                
                ZStack {
                    
                    ArchitectsGroupedListContentView(router: router, groupedArchitects: groupedArchitects)

                    if !isSearching {
                        MIASectionIndexView(scrollViewProxy: proxy, keys: groupedArchitects.keys.sorted())
                    }
                }
            }
        }
    }
    
    struct ArchitectsGroupedListContentView: View {
        
        @ObservedObject
        var router: MIARouter
        
        let groupedArchitects: [String: [Architect]]
        
        var body: some View {
            
            List {
                
                ForEach(groupedArchitects.keys.sorted(), id: \.self) { sectionKey in
                
                    ArchitectsGroupedListSectionView(
                        router: router,
                        sectionKey: sectionKey,
                        architects: groupedArchitects[sectionKey] ?? []
                    )
                }
            }
            .listStyle(.insetGrouped)
        }
    }
    
    struct ArchitectsGroupedListSectionView: View {
        
        @ObservedObject
        var router: MIARouter
        
        let sectionKey: String
        let architects: [Architect]
        
        var body: some View {
            
            Section(header: Text("\(sectionKey)")) {
                    
                ForEach(architects) { architect in
                    ArchitectsGroupedListRowView(router: router, architect: architect)
                }
            }
        }
    }
    
    struct ArchitectsGroupedListRowView: View {
        
        @ObservedObject
        var router: MIARouter
        
        let architect: Architect
        
        var body: some View {
            
            Text("\(architect.fullName)")
                .onTapGesture {
                    router.showArchitectDetail(id: architect.id)
                }
        }
    }
}

// MARK: - Computed Properties

private extension ArchitectsListSuccessView {
    
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

// MARK: - Previews

#Preview("Light") {

    let viewModel = ArchitectsListViewModel()
    
    Task {
        await viewModel.fetchData()
    }
    
    return ArchitectsListSuccessView()
        .environmentObject(MIARouter())
        .environmentObject(viewModel)
}

#Preview("Dark") {

    let viewModel = ArchitectsListViewModel()
    
    Task {
        await viewModel.fetchData()
    }
    
    return ArchitectsListSuccessView()
        .environmentObject(MIARouter())
        .environmentObject(viewModel)
        .preferredColorScheme(.dark)
}
