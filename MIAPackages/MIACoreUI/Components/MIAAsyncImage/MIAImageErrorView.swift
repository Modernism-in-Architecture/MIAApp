//
//  ImageErrorView.swift
//  MIACoreUI
//
//  Created by Sören Kirchner (privat) on 27.12.24.
//

import SwiftUI

struct MIAImageErrorView: View {

    let height: CGFloat

    var width: CGFloat { height * 1.4 }
    var fontSize: CGFloat { height / 8 }

    var body: some View {
        
        VStack(alignment: .center) {
            
            Spacer()
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: height / 2)
            Text("No image found")
                .font(.system(size: fontSize))
                .textCase(.uppercase)
            Spacer()
        }
        .opacity(0.4)
        .aspectRatio(contentMode: .fit)
        .frame(width: width, height: height)
    }
}
