//
//  MIASearchBar.swift
//  MIAapp
//
//  Created by Sören Kirchner on 01.06.22.
//

import SwiftUI

// MARK: - MIASearchBar

public struct MIASearchBar: View {
    
    @Binding
    var text: String
    
    @Binding
    var isSearching: Bool
    
    @FocusState
    private var isFocused: Bool
    
    public init(
        text: Binding<String>,
        isSearching: Binding<Bool>
    ) {
        
        self._text = text
        self._isSearching = isSearching
    }
    
    public var body: some View {
        
        content
            .disableAutocorrection(true)
            .padding()
            .onAppear {
                isFocused = true
            }
    }
}

// MARK: - Private Views

private extension MIASearchBar {
    
    var content: some View {
        
        HStack {
            
            searchField
            cancelButton
        }
    }
    
    var searchField: some View {
        
        HStack {
            
            Image(systemName: "magnifyingglass")
            
            TextField("Search", text: $text)
                .focused($isFocused)
            
            if !text.isEmpty {
                clearButton
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemFill))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray), lineWidth: 1))
    }
    
    var clearButton: some View {
        
        Button(action: clear) {
            
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
        }
    }
    
    var cancelButton: some View {
        Button("Cancel", action: cancel)
    }
}

private extension MIASearchBar {
    
    func cancel() {
        
        withAnimation {
            
            clear()
            isFocused = false
            isSearching.toggle()
        }
    }
    
    func clear() {
        text = ""
    }
}
