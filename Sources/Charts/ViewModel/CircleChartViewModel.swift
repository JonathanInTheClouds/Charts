//
//  CircleChartViewModel.swift
//  
//
//  Created by Mettaworldj on 2/23/22.
//

import Foundation

@available(iOS 13.0, *)
public protocol CircleChartViewModel: ChartViewModel {
    var dataSpacing: Double { get }
    var labelSpacing: Double { get }
}
