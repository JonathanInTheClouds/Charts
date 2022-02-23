//
//  LineGraph.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct LineGraph: Shape {
    /// Normalized data points between 0 and 1
    public var dataPoints: [CGPoint]
    
    public func path(in rect: CGRect) -> Path {
        return Path { path in
            guard dataPoints.count > 1 else { return }
            
            /// 1
            let start = dataPoints[0]
            var previousPoint = start
            path.move(to: previousPoint)
            
            for index in dataPoints.indices {
                let point = dataPoints[index]
                let x = point.x
                let y = point.y
                
                /// 2
                let deltaX = x - previousPoint.x
                let curvedXOffset = deltaX * 0.5
                
                /// 3
                path.addCurve(to: CGPoint(x: x, y: y), control1: CGPoint(x: previousPoint.x + curvedXOffset, y: previousPoint.y), control2: CGPoint(x: x - curvedXOffset, y: y))
                
                previousPoint = CGPoint(x: x, y: y)
            }
        }
        
    }
}
