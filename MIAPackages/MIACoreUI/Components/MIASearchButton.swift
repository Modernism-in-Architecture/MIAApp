//
//  MIASearchButton.swift
//  MIAapp
//
//  Created by Sören Kirchner on 01.06.22.
//

import SwiftUI

public struct MIASearchButton: View {
    
    @Binding
    var isSearching: Bool
    
    public init(isSearching: Binding<Bool>) {
        self._isSearching = isSearching
    }
    
    public var body: some View {
        
        Button(action: toggle) {
            Image(systemName: "magnifyingglass")
        }
    }
}

// MARK: - Private Methods

private extension MIASearchButton {
    
    func toggle() {
        
        withAnimation {
            isSearching.toggle()
        }
    }
}
