//
//  PieLabel.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct PieLabel: View {
    
    public let currentData: ChartDataProvidable
    public let spaceOffSet: Double
    public var  percentage: String {
        return "\(Int((currentData.value + spaceOffSet) * 100)) %"
    }
    
    public var body: some View {
        HStack {
            Text(percentage)
        }
        .padding(5)
        .background(currentData.color.opacity(0.15))
        .foregroundColor(currentData.color)
        .cornerRadius(10)
    }
}
