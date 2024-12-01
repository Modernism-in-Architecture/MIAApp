//
//  BuildingDetailView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 21.10.21.
//

import OSLog
import SwiftUI

// MARK: - BuildingDetailView

struct BuildingDetailView: View {

    @StateObject
    var buildingDetailViewModel = BuildingViewModel()
    
    @State
    var building: Building
        
    var body: some View {
        
        content
            .task {
//                let clock = ContinuousClock()
//                let elapsedTime = await clock.measure {
                    await buildingDetailViewModel.fetchData(for: building.id)
//                }
//                Logger.buildingDetail.debug("Time elapsed loading Detail: \(elapsedTime)")
            }
    }
}

extension BuildingDetailView {
    
    @ViewBuilder
    var content: some View {
        
        switch buildingDetailViewModel.detail {
            
        case .success(let detail):
            BuildingDetailSuccessView(building: building, buildingDetail: detail)
            
        case .loading:
            MIAActivityIndicator()
            
        case .error:
            // TODO: pass real error if changed to ManagerError
            MIAErrorView(error: .notImplementedError)
        }
    }
}

// struct MIADetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingDetailSuccessView(item: .example())
//    }
// }
