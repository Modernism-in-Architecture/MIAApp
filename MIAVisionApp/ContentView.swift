//
//  ContentView.swift
//  MIAVisionApp
//
//  Created by Sören Kirchner (privat) on 03.01.25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    var body: some View {
        
        VStack {
//            Model3D(named: "Scene", bundle: realityKitContentBundle)
//                .padding(.bottom, 50)
//
//            Text("Hello, world!")
            
            BuildingsListView()
            
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
