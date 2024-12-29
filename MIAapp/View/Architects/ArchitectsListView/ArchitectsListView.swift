//
//  ArchitectsListView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 06.02.22.
//

import SwiftUI
import MIACoreUI

struct ArchitectsListView: View {
    
    @EnvironmentObject
    var architectsController: ArchitectsListViewModel
    
    var body: some View {
        
        switch architectsController.state {
        case .success:
            ArchitectsListSuccessView()
            
        case .loading:
            MIAActivityIndicator()
            
        case let .error(error):
            // TODO: pass real error if changed to ManagerError
            MIAErrorView(error: .notImplementedError)
        }
    }
}
