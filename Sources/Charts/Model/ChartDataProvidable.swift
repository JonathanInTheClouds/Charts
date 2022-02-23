//
//  ChartDataProvidable.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import SwiftUI

@available(iOS 13.0, *)
public protocol ChartDataProvidable {
    var value: Double { get set }
    var label: String { get set }
    var color: Color { get set }
}
