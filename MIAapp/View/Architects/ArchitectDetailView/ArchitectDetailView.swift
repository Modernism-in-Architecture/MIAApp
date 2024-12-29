//
//  ArchitectView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 01.06.22.
//

import SwiftUI
import MIACoreUI

struct ArchitectDetailView: View {

    @StateObject 
    var architectViewModel = ArchitectDetailViewModel()
    
//    @EnvironmentObject
//    var router: MIARouter
    
    @State
    var id: Int

    var body: some View {
        
        content
            .task {
//                guard case let .detail(architect) = self.router.architectRoutes.last else {
//                    return
//                }
//                        
//                await architectViewModel.fetchData(for: architect.id)
                await architectViewModel.fetchData(for: id)
            }
    }
    
    @ViewBuilder
    var content: some View {
        
        switch architectViewModel.architectDetail {
            
        case .loading:
            MIAActivityIndicator()
            
        case .success(let detail):
            ArchitectDetailSuccessView(detail: detail)
            
        case .error(_):
            // TODO: Better Error Message
            Text("Error")
        }
    }
}

