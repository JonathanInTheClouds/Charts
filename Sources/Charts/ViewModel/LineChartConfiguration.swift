//
//  File.swift
//  
//
//  Created by Mettaworldj on 2/23/22.
//

import SwiftUI

@available(iOS 15.0, *)
public protocol LineChartConfiguration: ChartConfiguration {
    var animateChart: Bool { get set }
    
    var currentPlot: String { get set }
    
    var showPlot: Bool { get set }
    
    var offset: CGSize { get set }
    
    var translation: CGFloat { get set }
    
    var target: CGFloat? { get set }
}
