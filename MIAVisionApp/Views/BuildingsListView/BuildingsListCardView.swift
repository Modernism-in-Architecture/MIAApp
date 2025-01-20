//
//  BuildingsListCardView.swift
//  MIAVisionApp
//
//  Created by Sören Kirchner (privat) on 06.01.25.
//

import SwiftUI
import MIACoreUI
import Foundation

struct BuildingsListCardView: View {
    
    let imageUrl: URL?
    let title: String
    let subtitle: String
    
    var body: some View {
        
        VStack {
            
            MIAAsyncHeaderImage(url: imageUrl, background: .clear)
                .cornerRadius(16)
                .offset(z: 32)
            Text(title)
                .lineLimit(1)
                .font(.headline)
                .padding(.top, 16)
            Text(subtitle)
                .lineLimit(1)
                .font(.subheadline)
        }
        .cornerRadius(16)
        .padding(16)
    }
}

#Preview {
    BuildingsListCardView(imageUrl: URL(string: "https://modernism.s3.amazonaws.com/original_images/thumbs/BioOko_3.JPG.350x350_q85_crop.jpg"), title: "Titel", subtitle: "Subtitle")
}
