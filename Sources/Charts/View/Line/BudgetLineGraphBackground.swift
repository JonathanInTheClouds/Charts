//
//  BudgetLineGraphBackground.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import SwiftUI

@available(iOS 13.0, *)
struct BudgetLineGraphBackground: Shape {
    var data: CGFloat
    let min: CGFloat
    let max: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
        let point = (data - min) / (max - min)
        let y = (1 - point) * height
        return Path { path in
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: width, y: y))
        }
        
    }
}
