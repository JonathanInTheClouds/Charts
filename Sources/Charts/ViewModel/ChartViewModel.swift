//
//  ChartViewModel.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import Foundation

@available(iOS 15.0, *)
public protocol ChartViewModel: ObservableObject {
    var data: [ChartDataProvidable] { get set }
    var chartData: [ChartDataProvidable] { get }
}
