//
//  PieLabel.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import SwiftUI

@available(iOS 13.0, *)
public struct PieLabel: View {
    
    let currentData: ChartDataProvidable
    var  percentage: String {
        return "\(Int((currentData.value + 0.002) * 100)) %"
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
