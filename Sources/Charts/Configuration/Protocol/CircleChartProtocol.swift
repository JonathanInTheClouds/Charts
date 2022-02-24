//
//  CircleChartProtocol.swift
//  
//
//  Created by Mettaworldj on 2/23/22.
//

import Foundation

@available(iOS 15.0, *)
public protocol CircleChartProtocol: ChartProtocol {
    var dataSpacing: Double { get }
    var labelSpacing: Double { get }
}
