//
//  BuildingDetailView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 21.10.21.
//

import SwiftUI
import OSLog

struct BuildingView: View {

    @StateObject var detailController = BuildingViewModel()
    @State var building: Building
        
    var body: some View {
        
        switch detailController.detail {
            
        case .success(let detail):
            BuildingDetailView(building: building, buildingDetail: detail)
            
        case .loading:
            MIAActivityIndicator()
                .task {
                    let clock = ContinuousClock()
                    let elapsedTime = await clock.measure {
                        await detailController.fetchData(for: building.id)
                    }
                    Logger.buildingDetail.debug("Time elapsed loading Detail: \(elapsedTime)")
                }
            
        case .error(_):
            // TODO: pass real error if changed to ManagerError
            MIAErrorView(error: .notImplementedError)
        }
    }
}

//struct MIADetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingDetailView(item: .example())
//    }
//}
