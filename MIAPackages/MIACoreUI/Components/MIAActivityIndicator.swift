//
//  MIAActivityIndicator.swift
//  MIAapp
//
//  Created by Sören Kirchner on 14.02.22.
//

import SwiftUI

// MARK: - MIAActivityIndicator

public struct MIAActivityIndicator: View {
    
    @State private var endPoint = 0.0
    
    public init(endPoint: Double = 0.0) {
        self.endPoint = endPoint
    }

    public var body: some View {
        
        ZStack {
            Ring(endPoint: endPoint)
                .stroke(Color.green, lineWidth: 4)
                .rotationEffect(Angle(degrees: 90))
                .task {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: false)) {
                        self.endPoint = 0.99
                    }
                }
            Image("mia")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
        }
        .frame(width: 100, height: 100)
    }
}

// MARK: - Ring

struct Ring: Shape {
    
    var endPoint: Double
    var delayPoint = 0.5

    var animatableData: Double {
        
        get {
            endPoint
        }
        
        set {
            endPoint = newValue
        }
    }

    func path(in rect: CGRect) -> Path {
        
        Path { path in
            
            let startPoint = (endPoint > delayPoint) ? (2 * endPoint) : 0
            path.addArc(
                center: CGPoint(x: rect.size.width/2, y: rect.size.width/2),
                radius: rect.size.width/2,
                startAngle: .normal(startPoint),
                endAngle: .normal(endPoint),
                clockwise: false
            )
        }
    }
}

extension Angle {
    
    static func normal(_ value: Double) -> Angle {
        .degrees(value * 360)
    }
}

// MARK: - MIAActivityIndicator_Previews

struct MIAActivityIndicator_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            
            MIAActivityIndicator()
                .scaleEffect(0.5)
            MIAActivityIndicator()
                .scaleEffect(1)
        }
    }
}
