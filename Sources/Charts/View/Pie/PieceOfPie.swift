//
//  PieceOfPie.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import SwiftUI

@available(iOS 13.0, *)
public struct PieceOfPie: Shape {
    
    let startDegree: Double
    let endDegree: Double
    
    public func path(in rect: CGRect) -> Path {
        return Path { p in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            p.move(to: center)
            p.addArc(center: center, radius: rect.width / 2,
                     startAngle: Angle(degrees: startDegree),
                     endAngle: Angle(degrees: endDegree),
                     clockwise: false)
            p.closeSubpath()
        }
    }
}

