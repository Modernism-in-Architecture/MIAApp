//
//  MIAToolBarLogo.swift
//  MIAapp
//
//  Created by Sören Kirchner on 01.03.22.
//

import SwiftUI

public struct MIAToolBarLogo: View {
    
    public init() {}
    
    public var body: some View {
        
        Image("mia")
            .resizable()
            .scaledToFit()
            .frame(width: 36)
    }
}

#Preview {
    MIAToolBarLogo()
}
