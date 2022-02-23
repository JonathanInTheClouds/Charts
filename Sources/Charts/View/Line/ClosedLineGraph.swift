//
//  ClosedLineGraph.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import SwiftUI

@available(iOS 13.0, *)
struct ClosedLineGraph: Shape {
    var dataPoints: [CGPoint]
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            guard dataPoints.count > 1 else { return }
            
            var previousPoint = dataPoints[0]
            path.move(to: previousPoint)
            
            for index in dataPoints.indices {
                let point = dataPoints[index]
                let x = point.x
                let y = point.y
                
                let deltaX = x - previousPoint.x
                let curvedXOffset = deltaX * 0.5
                
                path.addCurve(to: CGPoint(x: x, y: y), control1: CGPoint(x: previousPoint.x + curvedXOffset, y: previousPoint.y), control2: CGPoint(x: x - curvedXOffset, y: y))
                
                previousPoint = point
            }
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height + 5))
            path.addLine(to: CGPoint(x: 0, y: rect.height + 5))
        }
        
    }
}
