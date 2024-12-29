//
//  SectionIndexView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 31.05.22.
//

import SwiftUI

// MARK: - MIASectionIndexView

public struct MIASectionIndexView: View {
    
    let generator = UIImpactFeedbackGenerator(style: .light)
    let scrollViewProxy: ScrollViewProxy
    
    @State
    var keys: [String]
    
    @State
    private var previousKey: String? = .none
    
    public init(scrollViewProxy: ScrollViewProxy, keys: [String]) {
        
        self.scrollViewProxy = scrollViewProxy
        self.keys = keys
    }
    
    public var body: some View {
        
        HStack {
            
            Spacer()
            keyList
                .overlay(
                    gestureLayer
                )
        }
    }
}

// MARK: - Views

private extension MIASectionIndexView {
    
    var keyList: some View {
        
        VStack {
            
            ForEach(keys, id: \.self) { key in
                
                VStack {
                    KeyView(key: key)
                }
            }
        }
    }
    
    var gestureLayer: some View {
        
        GeometryReader { geometry in

            Color.clear
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            updateScrollView(value: value, geometry: geometry)
                        }
                        .onEnded { value in
                            updateScrollView(value: value, geometry: geometry)
                        }
                )
        }
    }
}

// MARK: - MIASectionIndexView.KeyView

private extension MIASectionIndexView {
 
    struct KeyView: View {
        
        let key: String
        
        var body: some View {
            
            Text(key)
                .foregroundColor(.blue)
                .font(.footnote)
                .padding(.leading, 30)
                .padding(.trailing, 5)
        }
    }
}

// MARK: - Private Methods

private extension MIASectionIndexView {
        
    func updateScrollView(value: DragGesture.Value, geometry: GeometryProxy) {

        if let newIndex = calculateIndex(from: value, geometry: geometry) {
            moveTo(key: keys[newIndex])
        }
    }
    
    func calculateIndex(from value: DragGesture.Value, geometry: GeometryProxy) -> Int? {
        
        let yPosition = value.startLocation.y + value.translation.height
        let region = yPosition / geometry.size.height
        let index = Int(region * CGFloat(keys.count))
        
        return 0 ..< keys.count ~= index ? index : .none
    }
    
    func moveTo(key: String) {
        
        scrollViewProxy.scrollTo(key, anchor: .top)
        
        if key != previousKey {
            
            generator.impactOccurred()
            previousKey = key
        }
    }
}
