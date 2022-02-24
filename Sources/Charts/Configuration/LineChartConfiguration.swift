//
//  LineChartConfiguration.swift
//  
//
//  Created by Mettaworldj on 2/23/22.
//

import SwiftUI

@available(iOS 15.0, *)
public class LineChartConfiguration: LineChartProtocol {
    public var animateChart: Bool = false
    
    public var currentPlot: String = ""
    
    public var showPlot: Bool = false
    
    public var offset: CGSize = .zero
    
    public var translation: CGFloat = 0
    
    public var target: CGFloat?
    
    public var data: [ChartDataProvidable] = [ChartDataProvidable]()
    
    public var chartData: [ChartDataProvidable] {
        return data
    }
    
    public init() {
        
    }
}
