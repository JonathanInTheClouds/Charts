//
//  ChartDataProvidable.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import SwiftUI

@available(iOS 13.0, *)
public protocol ChartDataProvidable {
    var value: Double { get }
    var label: String { get }
    var color: Color { get }
}
