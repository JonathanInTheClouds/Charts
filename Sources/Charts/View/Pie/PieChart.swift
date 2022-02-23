//
//  File.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//


import SwiftUI

@available(iOS 13.0, *)
public struct PieChart<T>: View where T: ChartViewModel {
    
    @ObservedObject var vm: T
    @State var selectedPieChartElement: Int? = nil
    let action: ((ChartDataProvidable) -> Void)?
    
    
    var body: some View {
        ZStack {
            ForEach(0 ..< vm.data.count) { index in
                let currentData = vm.data[index]
                let currentEndDegree = currentData.value * 360
                let lastDegree = vm.data.prefix(index)
                    .map { $0.value }.reduce(0, +) * 360
                
                ZStack {
                    PieceOfPie(startDegree: lastDegree, endDegree: lastDegree + currentEndDegree)
                        .fill(currentData.color)
                        .scaleEffect(index == selectedPieChartElement ? 1.2 : 1.0)
                    
                    GeometryReader { geometry in
                        Text(currentData.label)
                            .position(getLabelCoordinate(in: geometry.size, for: lastDegree + (currentEndDegree / 2)))
                    }
                    .scaleEffect(index == selectedPieChartElement ? 1.2 : 1.0)
                }
                .onTapGesture {
                    withAnimation() {
                        if index == selectedPieChartElement {
                            selectedPieChartElement = nil
                        } else {
                            selectedPieChartElement = index
                            if let action = action {
                                action(currentData)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getLabelCoordinate(in geoSize: CGSize, for degree: Double) -> CGPoint {
        let center = CGPoint(x: geoSize.width / 2, y: geoSize.height / 2)
        let radius = (geoSize.width / 3)
        let radian = CGFloat(degree) * (CGFloat.pi / 180)
        let yCoordinate = radius * sin(radian)
        let xCoordinate = radius * cos(radian)
        return CGPoint(x: center.x + xCoordinate, y: center.y + yCoordinate)
    }
}
