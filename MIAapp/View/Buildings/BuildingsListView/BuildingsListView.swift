//
//  BuildingsListView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI

struct BuildingsListView: View {
    
    @EnvironmentObject 
    var buildingsViewModel: BuildingsListViewModel
    
    @EnvironmentObject
    var router: MIARouter

    var body: some View {
        
        content
    }
}

// MARK: - Views

extension BuildingsListView {
    
    @ViewBuilder
    var content: some View {
        
        switch buildingsViewModel.state {
            
        case .success:
            BuildingsListSuccessView(buildings: buildingsViewModel.buildings)
            
        case .loading:
            MIAActivityIndicator()
            
        case .error(let error):
            // TODO: pass real error if changed to ManagerError
            MIAErrorView(error: .notImplementedError)
        }
    }
}

//struct MIAListView_Previews: PreviewProvider {
//
//    @ObservedObject var mia: BuildingsListViewModel
//
//    static var previews: some View {
//        MIAListView(mia: mia)
//    }
//}
