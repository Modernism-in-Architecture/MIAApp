//
//  MIAAsyncHeaderImage.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.05.22.
//

import SwiftUI

public struct MIAAsyncHeaderImage: View {
    
    let url: URL?
    let background: Color
    
    public init(url: URL?, background: Color) {
        
        self.url = url
        self.background = background
    }
    
    public var body: some View {
        
        Rectangle()
            .aspectRatio(1.3, contentMode: .fill)
            .overlay{
                MIAAsyncImageView(url, background: background)
            }
            .clipped()
    }
}
