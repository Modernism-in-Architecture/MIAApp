//
//  MIAVisionAppApp.swift
//  MIAVisionApp
//
//  Created by Sören Kirchner (privat) on 03.01.25.
//

import SwiftUI
//import MIACoreUI

@main
struct MIAVisionAppApp: App {
    
    @StateObject
    var buildingsListViewModel = BuildingsListViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
        .environmentObject(buildingsListViewModel)
    }
}
