//
//  BuildingDetailSuccessView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.05.22.
//

import MapKit
import OSLog
import SwiftUI

// MARK: - BuildingDetailSuccessView

struct BuildingDetailSuccessView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject
    var router: MIARouter
  
    @EnvironmentObject
    var mapViewModel: MIAMapViewModel
    
    // TODO: - Remove
    @State
    var building: Building
    
    @State
    var buildingDetail: BuildingDetail
    
    @State
    private var showShareSheet = false
    
    @State
    private var sharedItems = []
    
    var body: some View {
        
        content
            .onAppear {
                Logger.buildingDetail.debug("debug")
                Logger.buildingDetail.debug("\(building.coordinate.debugDescription)")
            }
    }
}

// MARK: - Body

private extension BuildingDetailSuccessView {
    
    var content: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                
                MIAAsyncHeaderImage(url: building.feedImage)
                details
                    .padding()
            }
        }
        .padding(.top, 10)
        .navigationTitle(building.name)
        .toolbar {
            
            HStack {
                
                BookmarkToolbarView(id: building.id)
                MIAShareView(url: buildingDetail.absoluteURL)
            }
        }
    }
    
    var details: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            MIASection("Building") {
                buildingDetails
            }
            MIASection("Architects", ignoreIf: buildingDetail.architects.isEmpty) {
                architectsDetails
            }
            MIASection("Description", ignoreIf: buildingDetail.description.isEmpty) {
                MIAFoldableText(text: buildingDetail.attributedDescription)
            }
            MIASection("History", ignoreIf: buildingDetail.description.isEmpty) {
                MIAFoldableText(text: buildingDetail.attributedHistory)
            }
            MIASection("Location") {
                locationDetail
            }
            MIASection("Impressions", ignoreIf: buildingDetail.galleryImages.isEmpty) {
                BuildingDetailGridGalleryView(images: buildingDetail.galleryImages)
                    .padding(.top, 5)
            }
        }
    }
    
    var buildingDetails: some View {
        
        VStack(alignment: .leading) {
            
            Text(buildingDetail.name)
                .font(.headline)
                .padding(.bottom, 5)
            if !buildingDetail.buildingType.isEmpty {
                Text(buildingDetail.buildingType)
                    .padding(.bottom, 5)
            }
            Text(buildingDetail.address)
            Text(buildingDetail.cityCountry)
            VStack(alignment: .leading) {
                
                if !buildingDetail.todaysUse.isEmpty {
                    Text("Today's Use: \(buildingDetail.todaysUse)")
                }
                if !buildingDetail.yearOfConstruction.isEmpty {
                    Text("Year of Construction: \(buildingDetail.yearOfConstruction)")
                }
            }
            .padding(.top, 5)
        }
    }
    
    var architectsDetails: some View {
        
        ForEach(buildingDetail.architects) { architect in
            
            Text(architect.fullName)
                .underline()
                .onTapGesture {
                    router.showArchitectDetail(architect: architect)
                }
                .buttonStyle(.plain)
        }
    }
    
    var locationDetail: some View {
        
        ZStack {
            
            BuildingDetailMapView(building: building)
                .frame(height: 250)
                .mask(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 5)
                .allowsHitTesting(false) // No Interaction
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    
                    print("Tapped")
                    mapViewModel.setCameraPosition(to: building)
                    router.toRoot()
                    router.showMap(with: building)
                }
        }
    }
}

#Preview {
    BuildingDetailSuccessView(building: .schunckMock, buildingDetail: .schunckMock)
}
